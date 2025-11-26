return {
    -- ui improvements
    { 'stevearc/dressing.nvim' },

    { 'nmac427/guess-indent.nvim' },

    { 'mrcjkb/rustaceanvim', version = '^4', lazy = false },

    -- working with word variants
    { 'tpope/vim-abolish' },

    { 'jwalton512/vim-blade' },

    { 'tpope/vim-repeat', keys = '.' },

    { 'tpope/vim-surround' },

    -- mappings for next/previous, option toggling, en-/decoding
    { 'tpope/vim-unimpaired' },

    { 'andrewradev/splitjoin.vim', init = function()
          vim.g.splitjoin_html_attributes_brackets_on_new_line = 1
          vim.g.splitjoin_trailing_comma = 1
          vim.g.splitjoin_php_method_chain_full = 1
        end,
    },
}
