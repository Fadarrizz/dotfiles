require("nvim-tree").setup({
    filters = {
        dotfiles = false,
    },
    sync_root_with_cwd = true,
    respect_buf_cwd = true,
    update_focused_file = {
        enable = true,
        update_root = false
    },
})

local function open_nvim_tree()
    -- open the tree
    require("nvim-tree.api").tree.open()
end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

local map = vim.api.nvim_set_keymap

map('n', '<leader>nt', ':NvimTreeToggle<CR>', { silent = true, noremap = true, desc = 'Toggle Nvim Tree' })
map('n', '<leader>ns', ':NvimTreeFindFile<CR>', { silent = true, noremap = true, desc = 'Search Nvim Tree' })
map('n', '<leader>nc', ':NvimTreeCollapse<CR>', { silent = true, noremap = true, desc = 'Collapse Nvim Tree' })
map('n', '<leader>nf', ':NvimTreeFocus<CR>', { silent = true, noremap = true, desc = 'Focus Nvim Tree' })
