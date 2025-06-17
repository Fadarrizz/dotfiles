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

    {
        "echasnovski/mini.splitjoin",
        enabled = true,
        config = function()
            require("mini.splitjoin").setup()
        end,
    },
}
