return {
    'vim-test/vim-test',
    enabled = true,
    keys = {
        { "<leader>tn", vim.cmd.TestNearest, 'Test Nearest' },
        { "<leader>tf", vim.cmd.TestFile, 'Test Nearest' },
        { "<leader>ta", vim.cmd.TestSuite, 'Test Nearest' },
        { "<leader>tl", vim.cmd.TestLast, 'Test Nearest' },
        { "<leader>tg", vim.cmd.TestVisit, 'Test Nearest' },
    },
    config = function()
        vim.g['test#strategy'] = "neovim"
        vim.g['test#neovim#start_normal'] = 1
        vim.g[':test#echo_command'] = 0

        -- JS
        vim.g['test#javascript#runner'] = 'jest'
        vim.g['test#javascript#jest#executable'] = 'npm test'

        -- Rust
        vim.g['test#rust#runner'] = 'cargotest'
    end
}
