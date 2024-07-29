local util = require('fadarrizz.util')
local dap = require('dap')

return {
    {
        enabled = false,
        'nvim-neotest/neotest',
        keys = {
            { '<leader>tn', function() require('neotest').run.run() end,                     desc = 'Run test' },
            { '<leader>td', function() require('neotest').run.run({ strategy = 'dap' }) end, desc = 'Run test with dap' },
            { '<leader>ta', function() require('neotest').run.attach() end,                  desc = 'Attach to test' },
            { '<leader>ts', function() require('neotest').run.stop() end,                    desc = 'Stop test' },
            { '<leader>tf', function() require('neotest').run.run(vim.fn.expand('%')) end,   desc = 'Run test file' },
            { '<leader>tg', function() require('neotest').run.run({ suite = true }) end,     desc = 'Run test suite' },
            { '<leader>to', function() require('neotest').output.open({ enter = true }) end, desc = 'Open test output' },
            { '<leader>pt', ':w<cr>:TestFile<cr>',                                           desc = 'Run test file (vim-test)' },
        },
        opts = function()
            return {
                discovery = {
                    enabled = true,
                },
                adapters = {
                    require('neotest-phpunit')({
                        root_files = { "composer.json", "phpunit.xml", "phpunit.xml.dist", ".github" },
                        filter_dirs = { "vendor" },
                        phpunit_cmd = function()
                            return "/Users/auke/.dotfiles/bin/dphpunit"
                        end,
                    }),
                    -- require('neotest-pest'),
                    require('neotest-go'),
                    require('rustaceanvim.neotest'),
                    require('neotest-vim-test')({
                        allow_file_types = { 'php' },
                    }),
                },
            }
        end,
        dependencies = {
            -- deps
            'nvim-neotest/nvim-nio',
            'nvim-lua/plenary.nvim',
            'antoinemadec/FixCursorHold.nvim',
            'nvim-treesitter/nvim-treesitter',
            -- Adapters
            'vim-test/vim-test',
            'nvim-neotest/neotest-vim-test',
            'olimorris/neotest-phpunit',
            'V13Axel/neotest-pest',
            'nvim-neotest/neotest-go',
        },
    },
}
