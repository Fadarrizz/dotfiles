require("nvim-tree").setup({
    filters = {
        dotfiles = false,
    }
})

local map = vim.api.nvim_set_keymap
local silent = { silent = true, noremap = true }

map('n', '<leader>tt', ':NvimTreeToggle<CR>', silent)
map('n', '<leader>tf', ':NvimTreeFindFile<CR>', silent)
map('n', '<leader>tc', ':NvimTreeCollapse<CR>', silent)
