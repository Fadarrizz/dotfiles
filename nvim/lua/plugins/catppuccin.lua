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
                harpoon = true,
                telescope = true,
                treesitter = true,
            },
        })
    end,
}
