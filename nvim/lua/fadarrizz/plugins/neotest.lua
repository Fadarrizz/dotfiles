-- Custom neotest strategy for debugging Kotlin/Gradle tests.
--
-- The fwcd kotlin-debug-adapter can only *attach* to a running JVM (its launch
-- mode runs a main class, not a Gradle test task). So we take the gradle command
-- neotest already built (with the --tests filter), append --debug-jvm so the test
-- worker suspends and opens a JDWP port, wait for the actual "Listening..." line,
-- then attach nvim-dap to that port. Waiting for the line avoids the timeout race
-- you'd hit by attaching on a fixed delay before Gradle finishes compiling.
local function kotlin_dap_strategy(spec, context)
    local nio = require("nio")
    nio.scheduler()
    local dap = require("dap")

    local cmd = spec.command
    if type(cmd) == "table" then cmd = table.concat(cmd, " ") end
    cmd = cmd .. " --debug-jvm"

    local project_root = vim.fn.getcwd()
    if spec.context and spec.context.test_resuls_directory then
        project_root = spec.context.test_resuls_directory:gsub("/build/test%-results/test$", "")
    end

    local output_path = vim.fn.tempname()
    local out = assert(io.open(output_path, "w"))
    local closed = false

    local listening = nio.control.future()
    local finished = nio.control.future()
    local listening_set = false
    local result_code

    local function on_data(_, data)
        for _, line in ipairs(data) do
            if not closed and line ~= "" then
                out:write(line .. "\n")
            end
            local port = line:match("Listening for transport dt_socket at address:%s*(%d+)")
            if port and not listening_set then
                listening_set = true
                listening.set(tonumber(port))
            end
        end
    end

    local job = vim.fn.jobstart({ "sh", "-c", cmd }, {
        cwd = spec.cwd,
        on_stdout = on_data,
        on_stderr = on_data,
        on_exit = function(_, code)
            result_code = code
            closed = true
            out:close()
            if not listening_set then
                listening_set = true
                listening.set(nil)
            end
            finished.set()
        end,
    })

    if job <= 0 then
        closed = true
        out:close()
        return nil
    end

    local port = listening.wait()

    if port ~= nil and result_code == nil then
        nio.scheduler()
        dap.run({
            type = "kotlin",
            request = "attach",
            name = "neotest: attach to test JVM",
            hostName = "localhost",
            port = port,
            timeout = 5000,
            projectRoot = project_root,
        })
    end

    return {
        is_complete = function() return result_code ~= nil end,
        output = function() return output_path end,
        attach = function() dap.repl.open() end,
        stop = function()
            if job > 0 then vim.fn.jobstop(job) end
            pcall(function() dap.terminate() end)
        end,
        result = function()
            finished.wait()
            return result_code
        end,
    }
end

return {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter",
        "nvim-neotest/neotest-go",
        "olimorris/neotest-phpunit",
        "V13Axel/neotest-pest",
        "weilbith/neotest-gradle",
    },
    keys = {
        { '<leader>tn', function() require('neotest').run.run() end,                          desc = 'Run nearest test' },
        { '<leader>tf', function() require('neotest').run.run(vim.fn.expand('%')) end,        desc = 'Run test file' },
        { '<leader>ta', function() require('neotest').run.run({ suite = true }) end,          desc = 'Run test suite' },
        { '<leader>tl', function() require('neotest').run.run_last() end,                     desc = 'Run last test' },
        { '<leader>ts', function() require('neotest').run.stop() end,                         desc = 'Stop test' },
        { '<leader>to', function() require('neotest').output.open({ enter = true }) end,      desc = 'Open test output' },
        { '<leader>tt', function() require('neotest').summary.toggle() end,                   desc = 'Toggle test summary' },
        { '<leader>td', function()
            local strategy = vim.bo.filetype == 'kotlin' and kotlin_dap_strategy or 'dap'
            require('neotest').run.run({ strategy = strategy })
        end, desc = 'Debug nearest test' },
    },
    config = function()
        -- Wraps neotest-phpunit's build_spec to route tests through Laravel Sail.
        --
        -- The core problem: neotest-phpunit passes `--log-junit /tmp/neotest_xxx.xml`
        -- to phpunit. When phpunit runs inside the container, it writes to the container's
        -- /tmp — not the host's — so neotest can't read the results.
        --
        -- Fix: redirect the XML to storage/.neotest/ (mounted in Sail as /var/www/html),
        -- translate any absolute host paths in the command to container paths, and
        -- prepend `sail exec -T laravel.test` to route execution into the container.
        local function phpunit_adapter()
            local CONTAINER_ROOT = "/var/www/html"

            local adapter = require('neotest-phpunit')({
                root_files = { "composer.json", "phpunit.xml", "phpunit.xml.dist" },
                filter_dirs = { ".git", "node_modules", "vendor" },
            })

            if vim.fn.executable("vendor/bin/sail") ~= 1 then
                return adapter
            end

            local original_build_spec = adapter.build_spec
            local original_results    = adapter.results

            adapter.build_spec = function(...)
                local spec = original_build_spec(...)
                if not spec then return nil end

                local project_root = vim.fn.getcwd()
                vim.fn.mkdir(project_root .. "/storage/.neotest", "p")

                local host_results = project_root .. "/storage/.neotest/phpunit.xml"
                local cont_results = CONTAINER_ROOT .. "/storage/.neotest/phpunit.xml"

                -- Translate absolute host paths in the command to container paths.
                -- This covers the test file argument (e.g. /home/user/project/tests/Foo.php)
                -- and the --log-junit value if it happens to be inside the project dir.
                for i, v in ipairs(spec.command) do
                    if type(v) == "string" and v:sub(1, #project_root) == project_root then
                        spec.command[i] = CONTAINER_ROOT .. v:sub(#project_root + 1)
                    end
                end

                -- If phpunit received the project root as its directory argument (suite
                -- run), remove it so phpunit falls back to phpunit.xml. Without this,
                -- phpunit scans the entire container root including vendor/.
                for i, v in ipairs(spec.command) do
                    if v == CONTAINER_ROOT then
                        table.remove(spec.command, i)
                        break
                    end
                end

                -- Override --log-junit to the mounted results path regardless of where
                -- neotest-phpunit put it (typically a macOS /var/folders temp path).
                -- neotest-phpunit passes this as a single "--log-junit=<path>" string.
                for i, v in ipairs(spec.command) do
                    if type(v) == "string" and v:match("^%-%-log%-junit=") then
                        spec.command[i] = "--log-junit=" .. cont_results
                        break
                    end
                end

                -- Replace the phpunit binary with `sail phpunit`. Sail handles APP_SERVICE
                -- (read from .env, no hardcoded container name) and -T (added automatically
                -- when stdin is not a tty, which is always the case when neotest runs this).
                spec.command[1] = "vendor/bin/sail"
                table.insert(spec.command, 2, "phpunit")

                -- Store project_root so the results wrapper can translate paths back.
                spec.context.results_path  = host_results
                spec.context.project_root  = project_root

                return spec
            end

            -- neotest-phpunit builds test IDs from the `file` attribute in the JUnit XML.
            -- phpunit running in the container writes container paths (/var/www/html/...)
            -- there, but neotest discovered tests using host paths. Translate them back so
            -- the result IDs match the discovered position IDs.
            adapter.results = function(test, result, tree)
                local results     = original_results(test, result, tree)
                local proj_root   = test.context and test.context.project_root
                if not results or not proj_root then return results end

                local translated = {}
                for id, data in pairs(results) do
                    local new_id = id:gsub("^" .. vim.pesc(CONTAINER_ROOT), proj_root)
                    translated[new_id] = data
                end
                return translated
            end

            return adapter
        end

        -- neotest-gradle's build_spec runs a *second* Gradle invocation
        -- (`gradle properties`) just to read the `testResultsDir` property — which
        -- Gradle 9 removed, so it resolves to "null" and result collection dies on
        -- `null/test`. Replace build_spec with one that builds the test command
        -- directly and points at the standard default `build/test-results/test`:
        -- one Gradle run per test, and no dependency on the removed property.
        local function gradle_adapter()
            local adapter = require("neotest-gradle")
            local lib = require("neotest.lib")
            local find_project_directory =
                require("neotest-gradle.hooks.find_project_directory")

            adapter.build_spec = function(args)
                local position = args.tree:data()
                local project_directory = find_project_directory(position.path)

                local wrapper_dir =
                    lib.files.match_root_pattern("gradlew")(project_directory)
                local gradle = wrapper_dir
                    and (wrapper_dir .. lib.files.sep .. "gradlew")
                    or "gradle"

                local command = { gradle, "--project-dir", project_directory, "test" }

                -- Filter to the selected test/class. A file run expands to one
                -- --tests per namespace (test class) in the file; a dir run keeps
                -- no filter and executes everything.
                if position.type == "test" or position.type == "namespace" then
                    vim.list_extend(command, { "--tests", "'" .. position.id .. "'" })
                elseif position.type == "file" then
                    for _, pos in args.tree:iter() do
                        if pos.type == "namespace" then
                            vim.list_extend(command, { "--tests", "'" .. pos.id .. "'" })
                        end
                    end
                end

                return {
                    command = table.concat(command, " "),
                    context = {
                        -- NOTE: misspelled key matches neotest-gradle's own context field.
                        test_resuls_directory = project_directory
                            .. "/build/test-results/test",
                    },
                }
            end

            return adapter
        end

        require("neotest").setup({
            discovery = { enabled = true, filter_dirs = { ".git", "node_modules", "vendor" } },
            output = { enabled = true, open_on_run = "short" },
            status = { enabled = true, signs = true },
            adapters = {
                phpunit_adapter(),
                require("neotest-go")({
                    experimental = { test_table = true },
                    args = { "-count=1", "-timeout=60s" },
                }),
                require("neotest-pest"),
                gradle_adapter(),
            },
        })
    end,
}
