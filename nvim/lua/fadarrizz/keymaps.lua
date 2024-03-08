local map = vim.keymap.set

-- Easier split navigation
map('n', '<C-J>', '<C-W><C-J>', { desc = 'split down' })
map('n', '<C-K>', '<C-W><C-K>', { desc = 'split up' })
map('n', '<C-L>', '<C-W><C-L>', { desc = 'split left' })
map('n', '<C-H>', '<C-W><C-H>', { desc = 'split right' })

-- Move highlighted block up and down
map('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'move hl block down' })
map('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'move hl block up' })

-- Maintain the cursor position when yanking a visual selection.
-- http://ddrscott.github.io/blog/2016/yank-without-jank/
map('v', 'y', 'myy`y')
map('v', 'Y', 'myY`y')

-- Paste without registering deleted stuff
map('x', '<leader>dp', '"_dP', { desc = 'paste without registering' })

-- Rename word under cursor in current buffer
map("n", "<leader>rw", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", { desc = 'rename under cursor' })

-- Select all text in current buffer
map('n', '<Leader>a', ':keepjumps normal! ggVG<CR>', { desc = 'hl all' })

-- Go to first character in line
map('n', '<Leader>g', '^', { desc = 'goto first in line' })

-- Go to last character in line
map('n', '<Leader>l', 'g_', { desc = 'goto last in line' })

map('n', 'U', '<C-r>', { desc = 'easier redo' })

-- Write file
map('n', '<Leader>w', ':write<CR>', { desc = 'write' })

-- Quick quit
map('n', '<Leader>qq', ':quit<CR>', { desc = 'quick quit' })

-- Quit all
map('n', '<Leader>qa', ':quitall<CR>', { desc = 'quit all' })

-- Navigate between buffers
map('n', '[b', ':bprevious<CR>', { desc = 'prev buffer' })
map('n', ']b', ':bnext<CR>', { desc = 'next buffer' })

-- Make file executable
map('n', '<leader>x', '<cmd>!chmod +x %<CR>', { silent = true, desc = 'make file executable' })

-- Remap terminal normal mode
map('t', '<C-o>', '<C-\\><C-n>')
