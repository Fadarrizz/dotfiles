local util = require('fadarrizz.util')

return {
    "nvim-neotest/neotest",
    enabled = false,
    dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter",
        "nvim-neotest/neotest-go",
        "olimorris/neotest-phpunit",
    },
    keys = {
        { '<leader>tn', function() require('neotest').run.run() end, desc = 'Run test' },
        { '<leader>td', function() require('neotest').run.run({ strategy = 'dap' }) end, desc = 'Run test with dap' },
        { '<leader>ta', function() require('neotest').run.attach() end, desc = 'Attach to test' },
        { '<leader>ts', function() require('neotest').run.stop() end, desc = 'Stop test' },
        { '<leader>tf', function() require('neotest').run.run(vim.fn.expand('%')) end,desc = 'Run test file' },
        { '<leader>tg', function() require('neotest').run.run({ suite = true }) end, desc = 'Run test suite' },
        { '<leader>to', function() require('neotest').output.open({ enter = true }) end, desc = 'Open test output' },
        { '<leader>pt', ':TestFile<cr>', desc = 'Run test file (vim-test)' },
        { '<leader>tt', function() require('neotest').summary.toggle() end, desc = 'Toggle test summary' },
    },
    config = function ()
        require("neotest").setup({
            adapters = {
                require("neotest-go")({
                    experimental = { test_table = true },
                }),
            }
        })
    end,
}

-- return {
--     'nvim-neotest/neotest',
--     lazy = false,
--     keys = {
--         { '<leader>tn', function() require('neotest').run.run() end, desc = 'Run test' },
--         { '<leader>td', function() require('neotest').run.run({ strategy = 'dap' }) end, desc = 'Run test with dap' },
--         { '<leader>ta', function() require('neotest').run.attach() end, desc = 'Attach to test' },
--         { '<leader>ts', function() require('neotest').run.stop() end, desc = 'Stop test' },
--         { '<leader>tf', function() require('neotest').run.run(vim.fn.expand('%')) end,desc = 'Run test file' },
--         { '<leader>tg', function() require('neotest').run.run({ suite = true }) end, desc = 'Run test suite' },
--         { '<leader>to', function() require('neotest').output.open({ enter = true }) end, desc = 'Open test output' },
--         { '<leader>pt', ':TestFile<cr>', desc = 'Run test file (vim-test)' },
--         { '<leader>tt', function() require('neotest').summary.toggle() end, desc = 'Toggle test summary' },
--     },
--     config = function ()
--         require("neotest").setup({
--             discovery = { enabled = true },
--             diagnostic = { enabled = true },
--             output = { enabled = true, open_on_run = "short" },
--             quickfix = { enabled = true, open = false },
--             status = { enabled = true, virtual_text = false, signs = true, },
--             adapters = {
--                 require('neotest-phpunit'),
--                 -- require('neotest-phpunit')({
--                 --     -- root_files = { "composer.json", "phpunit.xml", "phpunit.xml.dist", ".github" },
--                 --     phpunit_cmd = function()
--                 --         return { "vendor/bin/sail", "artisan", "test" }
--                 --     end,
--                 -- }),
--                 -- require('neotest-phpunit')({
--                 --     phpunit_cmd = function () return util.sail('phpunit') end,
--                 -- }),
--                 -- require('neotest-pest'),
--                 require('neotest-go')({
--                     experimental = { test_table = true},
--                     args = { "-count=1", "-timeout=60s" },
--                     -- root_dir = function(path) return require("neotest-go.utils").find_go_mod(path) end,
--                 }),
--                 -- require('neotest-rust'),
--                 -- require('neotest-vim-test')({ allow_file_types = { 'php' } }),
--             },
--             log_level = vim.log.levels.DEBUG,
--         })
--     end,
--     -- opts = function()
--     --     local neotest_go = require('neotest-go')

--     --     return {
--     --         discovery = { enabled = true },
--     --         diagnostic = { enabled = true },
--     --         output = { enabled = true, open_on_run = "short" },
--     --         quickfix = { enabled = true, open = false },
--     --         status = { enabled = true, virtual_text = false, signs = true, },
--     --         adapters = {
--     --             require('neotest-phpunit'),
--     --             -- require('neotest-phpunit')({
--     --             --     -- root_files = { "composer.json", "phpunit.xml", "phpunit.xml.dist", ".github" },
--     --             --     phpunit_cmd = function()
--     --             --         return { "vendor/bin/sail", "artisan", "test" }
--     --             --     end,
--     --             -- }),
--     --             -- require('neotest-phpunit')({
--     --             --     phpunit_cmd = function () return util.sail('phpunit') end,
--     --             -- }),
--     --             -- require('neotest-pest'),
--     --             neotest_go({
--     --                 experimental = { test_table = true},
--     --                 args = { "-count=1", "-timeout=60s" },
--     --                 -- root_dir = function(path) return require("neotest-go.utils").find_go_mod(path) end,
--     --             }),
--     --             -- require('neotest-rust'),
--     --             -- require('neotest-vim-test')({ allow_file_types = { 'php' } }),
--     --         },
--     --         log_level = vim.log.levels.DEBUG,
--     --     }
--     -- end,
--     -- init = function ()
--     --     vim.g['test#strategy'] = 'neovim'
--     --     vim.g['test#neovim#start_normal'] = 1
--     --     vim.g[':test#echo_command'] = 0
--     --     vim.g['test#php#pest#executable'] = util.sail_or_bin('pest', true)
--     -- end,
--     dependencies = {
--         -- deps
--         {'nvim-neotest/nvim-nio', lazy = false},
--         {'nvim-lua/plenary.nvim', lazy = false},
--         {'antoinemadec/FixCursorHold.nvim', lazy = false},
--         {"nvim-treesitter/nvim-treesitter", lazy = false},
--         -- Adapters
--         -- 'vim-test/vim-test',
--         -- 'nvim-neotest/neotest-vim-test',
--         {'olimorris/neotest-phpunit', lazy = false},
--         -- { 'V13Axel/neotest-pest', branch = 'PHPUnit_Test_Support' },
--         { 'nvim-neotest/neotest-go', lazy = false },
--         -- 'rouge8/neotest-rust',
--     },
-- }
