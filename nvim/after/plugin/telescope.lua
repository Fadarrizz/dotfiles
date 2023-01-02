local map = vim.api.nvim_set_keymap
local silent = { silent = true, noremap = true }

map('n', '<leader>ff', '<cmd>lua require("telescope.builtin").find_files()<cr>', silent)
map('n', '<leader>fg', '<cmd>lua require("telescope.builtin").live_grep()<cr>', silent)
map('n', '<leader>fb', '<cmd>lua require("telescope.builtin").buffers()<cr>', silent)
map('n', '<leader>fh', '<cmd>lua require("telescope.builtin").help_tags()<cr>', silent)
