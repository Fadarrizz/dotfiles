return {
    {
        "numToStr/Comment.nvim",
        event = { "BufReadPre" },
        opts = function()
            return {
                pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
                ignore = '^$', -- ignores empty lines
            }
        end,
        config = function(_, opts)
            -- to skip backwards compatibility routines and speed up loading
            vim.g.skip_ts_context_commentstring_module = true

            require('Comment').setup(opts)
            require('Comment.ft').set('blade', { '{{-- %s --}}', '{{-- %s --}}' })
        end,
        dependencies = {
            'JoosepAlviste/nvim-ts-context-commentstring',
        },
    },
    {
        'JoosepAlviste/nvim-ts-context-commentstring',
        opts = { enable_autocmd = false },
    },
}
