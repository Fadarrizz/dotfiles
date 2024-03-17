return {
    { 'windwp/nvim-autopairs',          config = true },

    { 'sindrets/diffview.nvim' },

    -- ui improvements
    { 'stevearc/dressing.nvim' },

    { 'nmac427/guess-indent.nvim' },

    -- LSP injector (for non-LSP sources)
    { 'jose-elias-alvarez/null-ls.nvim' },

    { 'simrat39/rust-tools.nvim' },

    -- working with word variants
    { 'tpope/vim-abolish' },

    { 'jwalton512/vim-blade' },

    { 'tpope/vim-repeat', keys = '.' },

    { 'tpope/vim-surround' },

    -- mappings for next/previous, option toggling, en-/decoding
    { 'tpope/vim-unimpaired' },

    {
        "echasnovski/mini.splitjoin",
        enabled = true,
        config = function()
            require("mini.splitjoin").setup()
        end,
    },
}
