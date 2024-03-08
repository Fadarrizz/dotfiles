vim.g.skip_ts_context_commentstring_module = true

return {
    {
        "numToStr/Comment.nvim",
        config = function()
            require('Comment').setup()
            require('Comment.ft').set('blade', { '{{-- %s --}}', '{{-- %s --}}' })
        end,
        lazy = false,
    },
    {
        'JoosepAlviste/nvim-ts-context-commentstring',
        opts = { enable_autocmd = false },
    },
}
