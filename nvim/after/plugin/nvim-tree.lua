require("nvim-tree").setup({
    filters = {
        dotfiles = false,
    },
    sync_root_with_cwd = true,
    respect_buf_cwd = true,
    update_focused_file = {
        enable = true,
        update_root = true
    },
})

local function open_nvim_tree()
    -- open the tree
    require("nvim-tree.api").tree.open()
end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

local map = vim.api.nvim_set_keymap
local silent = { silent = true, noremap = true }

map('n', '<leader>tt', ':NvimTreeToggle<CR>', silent)
map('n', '<leader>tf', ':NvimTreeFindFile<CR>', silent)
map('n', '<leader>tc', ':NvimTreeCollapse<CR>', silent)
