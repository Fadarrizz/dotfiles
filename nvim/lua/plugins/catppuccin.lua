return {
    "catppuccin/nvim",
    lazy = false,
    priority = 1000,
    config = function()
        require("catppuccin").setup({
            flavour = "macchiato", -- latte, frappe, macchiato, mocha
            dim_inactive = {
                enabled = false,
                shade = "dark",
                percentage = 0.15,
            },
            integrations = {
                cmp = true,
                gitsigns = true,
                telescope = true,
            },
        })

        -- setup must be called before loading
        vim.cmd([[colorscheme catppuccin]])
    end,
}
