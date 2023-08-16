vim.keymap.set('n', '<leader>tn',vim.cmd.TestNearest, { desc = 'Test Nearest' })
vim.keymap.set('n', '<leader>tf',vim.cmd.TestFile, { desc = 'Test File' })
vim.keymap.set('n', '<leader>ta',vim.cmd.TestSuite, { desc = 'Test Suite' })
vim.keymap.set('n', '<leader>tl',vim.cmd.TestLast, { desc = 'Test Last' })
vim.keymap.set('n', '<leader>tg',vim.cmd.TestVisit, { desc = 'Test Visit' })

vim.g['test#strategy'] = "neovim"
vim.g['test#neovim#start_normal'] = 1
vim.g[':test#echo_command'] = 0

-- JS
vim.g['test#javascript#runner'] = 'jest'
vim.g['test#javascript#jest#executable'] = 'npm test'

-- Rust
vim.g['test#rust#runner'] = 'cargotest'
