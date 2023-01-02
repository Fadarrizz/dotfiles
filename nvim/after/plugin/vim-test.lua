local map = vim.api.nvim_set_keymap
local silent = { silent = true, noremap = true }

map('n', '<leader>tn', ':TestNearest<CR>', silent)
map('n', '<leader>T', ':TestFile<CR>', silent)
map('n', '<leader>tl', ':TestLast<CR>', silent)
map('n', '<leader>ta', ':TestSuite<CR>', silent)
