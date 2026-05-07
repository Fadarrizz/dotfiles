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
    },
    keys = {
        { '<leader>tn', function() require('neotest').run.run() end,                          desc = 'Run nearest test' },
        { '<leader>tf', function() require('neotest').run.run(vim.fn.expand('%')) end,        desc = 'Run test file' },
        { '<leader>ta', function() require('neotest').run.run({ suite = true }) end,          desc = 'Run test suite' },
        { '<leader>tl', function() require('neotest').run.run_last() end,                     desc = 'Run last test' },
        { '<leader>ts', function() require('neotest').run.stop() end,                         desc = 'Stop test' },
        { '<leader>to', function() require('neotest').output.open({ enter = true }) end,      desc = 'Open test output' },
        { '<leader>tt', function() require('neotest').summary.toggle() end,                   desc = 'Toggle test summary' },
        { '<leader>td', function() require('neotest').run.run({ strategy = 'dap' }) end,      desc = 'Debug nearest test' },
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
                require("neotest-pest")
            },
        })
    end,
}
