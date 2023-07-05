local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})
local packer_user_config = augroup('packer_user_config', {})

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function ()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

autocmd('BufWritePost', {
    group = packer_user_config,
    pattern = 'plugins.lua',
    command = 'source <afile> | PackerCompile'
})

local function open_nvim_tree()
    require("nvim-tree.api").tree.open()
end

vim.api.nvim_create_autocmd({ "VimEnter" }, {
    callback = open_nvim_tree,
})
