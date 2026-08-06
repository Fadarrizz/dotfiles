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
        project_root = spec.context.test_resuls_directory:gsub("/build/test%-results/[^/]+$", "")
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
        "codymikol/neotest-kotlin",
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
            local get_package_name =
                require("neotest-gradle.hooks.shared_utilities").get_package_name
            local xml = require("neotest.lib.xml")
            local uv = vim.uv or vim.loop

            -- Recursively delete a directory. build_spec runs in a fast event
            -- context (nio coroutine) where vim.fn.delete is forbidden, so use
            -- libuv's synchronous fs calls, which are allowed there.
            local function rm_rf(path)
                local handle = uv.fs_scandir(path)
                if not handle then
                    return
                end
                while true do
                    local name, kind = uv.fs_scandir_next(handle)
                    if not name then
                        break
                    end
                    local entry = path .. "/" .. name
                    if kind == "directory" then
                        rm_rf(entry)
                    else
                        uv.fs_unlink(entry)
                    end
                end
                uv.fs_rmdir(path)
            end

            -- Map a test file to its Gradle task via the source set it lives in.
            -- This project (and Gradle convention) splits sources as
            -- src/<sourceSet>/... where the source set name is also the task name:
            -- src/test -> `test`, src/intTest -> `intTest`. Without this we'd only
            -- ever run `test`, so integration tests would either not run or the
            -- unfiltered `intTest` task would run its entire suite.
            local function gradle_task_for(path)
                local source_set = path:match("/src/([^/]+)/")
                if source_set == "intTest" then
                    return "intTest"
                end
                return "test"
            end

            -- Build a Gradle `--tests` locator for a node. Gradle expects the JVM
            -- binary class name: package is dot-separated, but a NESTED class is
            -- joined to its outer class with `$` (e.g. Outer$Inner), then the
            -- method (backticks stripped) with a dot. neotest-gradle's position.id
            -- uses dots throughout, so a nested-class filter like Outer.Inner
            -- matches nothing ("No tests found"). Rebuild it from the tree, where
            -- each namespace/test node carries its raw handle_name.
            local function gradle_test_pattern(node)
                local position = node:data()
                local class_names = {}

                for parent in node:iter_parents() do
                    local parent_data = parent:data()
                    if parent_data.type == "namespace" and parent_data.handle_name then
                        table.insert(class_names, 1, parent_data.handle_name)
                    end
                end
                if position.type == "namespace" and position.handle_name then
                    table.insert(class_names, position.handle_name)
                end

                -- Fall back to the plain id if the tree lacks handle_name (e.g. a
                -- position discovered by a different adapter).
                if #class_names == 0 then
                    return position.id
                end

                local package_name = get_package_name(position.path)
                local prefix = package_name ~= "" and (package_name .. ".") or ""
                local class_name = table.concat(class_names, "$")

                if position.type == "namespace" then
                    return prefix .. class_name
                end

                local method_name = (position.handle_name or ""):gsub("`", "")
                return prefix .. class_name .. "." .. method_name
            end

            adapter.build_spec = function(args)
                local position = args.tree:data()
                local project_directory = find_project_directory(position.path)

                local wrapper_dir =
                    lib.files.match_root_pattern("gradlew")(project_directory)
                local gradle = wrapper_dir
                    and (wrapper_dir .. lib.files.sep .. "gradlew")
                    or "gradle"

                local task = gradle_task_for(position.path)
                local command = { gradle, "--project-dir", project_directory, task }

                -- This project's conventions chain the tasks together:
                --   test --finalizedBy--> jacocoTestReport --dependsOn--> intTest
                -- (see buildSrc kotlin-base-conventions / kotlin-it-conventions).
                -- So running a single `test` drags in the entire, UNFILTERED
                -- `intTest` suite via the report. Exclude the report and the
                -- sibling test task so only the targeted task runs.
                vim.list_extend(command, { "-x", "jacocoTestReport" })

                -- Only exclude the sibling test task if it actually exists in this
                -- module. Gradle errors ("Task 'intTest' not found") when -x names
                -- a task the project doesn't have, and not every module has an
                -- intTest source set. Presence of src/<sibling> means the task exists.
                local sibling = task == "test" and "intTest" or "test"
                if lib.files.is_dir(project_directory .. "/src/" .. sibling) then
                    vim.list_extend(command, { "-x", sibling })
                end

                -- Filter to the selected test/class. A file run expands to one
                -- --tests per namespace (test class) in the file; a dir run keeps
                -- no filter and executes everything.
                if position.type == "test" or position.type == "namespace" then
                    vim.list_extend(command, {
                        "--tests",
                        "'" .. gradle_test_pattern(args.tree) .. "'",
                    })
                elseif position.type == "file" then
                    for _, pos in args.tree:iter() do
                        if pos.type == "namespace" then
                            vim.list_extend(command, {
                                "--tests",
                                "'" .. gradle_test_pattern(args.tree:get_key(pos.id)) .. "'",
                            })
                        end
                    end
                end

                local results_directory =
                    project_directory .. "/build/test-results/" .. task

                -- Remove reports from the previous run before executing. When
                -- compilation (or test discovery) fails, Gradle aborts before the
                -- `test` task and leaves the old XML in place. collect_results would
                -- then re-read those stale passing reports and report a broken build
                -- as green. Clearing the dir first means a failed compile leaves it
                -- empty, so `results` falls back to surfacing the process output.
                rm_rf(results_directory)

                return {
                    command = table.concat(command, " "),
                    context = {
                        -- NOTE: misspelled key matches neotest-gradle's own context field.
                        test_resuls_directory = results_directory,
                    },
                }
            end

            local original_results = adapter.results

            -- neotest-gradle strips the first line of the failure message.
            -- Gradle puts AssertJ's expected/actual values in that line, so
            -- retain the complete XML message for both output and diagnostics.
            adapter.results = function(spec, process_result, tree)
                local results_directory = spec.context and spec.context.test_resuls_directory
                if not results_directory or not lib.files.is_dir(results_directory) then
                    -- Gradle does not create test reports when compilation or test
                    -- discovery fails. Let Neotest surface the process output instead.
                    return {}
                end

                local results = original_results(spec, process_result, tree)

                local function as_list(value)
                    return type(value) == "table" and #value > 0 and value or { value }
                end

                local function add_failure_message(test_case)
                    local failure = test_case.failure
                    if not failure or not failure._attr then
                        return
                    end

                    local test_name = test_case._attr.name:gsub("%(.*%)$", "")
                    local class_name = test_case._attr.classname
                    local candidate_ids = {
                        class_name .. "." .. test_name,
                        class_name:gsub("%$", ".") .. "." .. test_name,
                    }

                    local result
                    for _, id in ipairs(candidate_ids) do
                        if results[id] then
                            result = results[id]
                            break
                        end
                    end
                    if not result then
                        return
                    end

                    local message = failure._attr.message or failure[1]
                    if message then
                        result.short = message
                        result.errors = {
                            {
                                message = message,
                                line = result.errors and result.errors[1] and result.errors[1].line,
                            },
                        }
                    end
                end

                for _, file_path in ipairs(lib.files.find(results_directory, {
                    filter_dir = function(file_name)
                        return file_name:sub(-4) == ".xml"
                    end,
                })) do
                    local report = xml.parse(lib.files.read(file_path))
                    for _, suite in ipairs(as_list(report.testsuite)) do
                        for _, test_case in ipairs(as_list(suite.testcase)) do
                            add_failure_message(test_case)
                        end
                    end
                end

                return results
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
