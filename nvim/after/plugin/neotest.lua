require("neotest").setup({
    adapters = {
        require('neotest-jest')({
            jestCommand = "npm test --",
            jestConfigFile = "custom.jest.config.js",
            env = { CI = true },
            cwd = function(path)
                return vim.fn.getcwd()
            end,
        }),
        require('neotest-phpunit')({
            phpunit_cmd = function()
                return "vendor/bin/phpunit"
            end
        }),
    },
})

-- local neotest = require('neotest')

-- vim.keymap.set('n', '<leader>tn', "", { callback = neotest.run.run(), noremap = true })
-- vim.keymap.set('n', '<leader>tf', require('neotest').run.run(vim.fn.expand("%")), {})
-- vim.keymap.set('n', '<leader>td', require('neotest').run.run({strategy = "dap"}), {})
-- vim.keymap.set('n', '<leader>ts', require('neotest').run.stop(), {})
