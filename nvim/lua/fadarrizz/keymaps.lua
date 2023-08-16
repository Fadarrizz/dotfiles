local map = vim.keymap.set

-- Easier split navigation
map('n', '<C-J>', '<C-W><C-J>')
map('n', '<C-K>', '<C-W><C-K>')
map('n', '<C-L>', '<C-W><C-L>')
map('n', '<C-H>', '<C-W><C-H>')

-- Move highlighted block up and down
map('v', 'J', ":m '>+1<CR>gv=gv")
map('v', 'K', ":m '<-2<CR>gv=gv")

-- Paste without registering deleted stuff
map('x', '<leader>dp', '"_dP')

-- Rename word under cursor in current buffer
map("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")

-- Select all text in current buffer
map('n', '<Leader>a', ':keepjumps normal! ggVG<CR>')

-- Go to first character in line
map('', '<Leader>g', '^')

-- Go to last character in line
map('', '<Leader>l', 'g_')

-- Write file
map('n', '<Leader>w', ':write<CR>')

-- Safe quit
map('n', '<Leader>qq', ':quitall<CR>')

-- Navigate between buffers
map('n', '[b', ':bprevious<CR>')
map('n', ']b', ':bnext<CR>')

-- Make file executable
map('n', '<leader>x', '<cmd>!chmod +x %<CR>', { silent = true })

-- Remap terminal normal mode
map('t', '<C-o>', '<C-\\><C-n>')
