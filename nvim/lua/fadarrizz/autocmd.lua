local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})
local remember_folds = augroup('RememberFolds', {})

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

autocmd('BufWinLeave', {
    group = remember_folds,
    pattern = '*.*',
    command = 'mkview'
})

autocmd('BufWinEnter', {
    group = remember_folds,
    pattern = '*.*',
    command = 'silent! loadview'
})
