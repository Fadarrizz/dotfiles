vim.keymap.set('n', '<leader>tn',vim.cmd.TestNearest)
vim.keymap.set('n', '<leader>tf',vim.cmd.TestFile)
vim.keymap.set('n', '<leader>ta',vim.cmd.TestSuite)
vim.keymap.set('n', '<leader>tl',vim.cmd.TestLast)
vim.keymap.set('n', '<leader>tg',vim.cmd.TestVisit)

vim.g['test#strategy'] = "neovim"
vim.g['test#neovim#start_normal'] = 1

-- JS
vim.g['test#javascript#runner'] = 'jest'
vim.g['test#javascript#jest#executable'] = 'npm test'

-- Rust
vim.g['test#rust#runner'] = 'cargotest'
