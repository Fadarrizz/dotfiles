return {
    "catppuccin/nvim",
    lazy = false,
    priority = 1000,
    config = function()
        require("catppuccin").setup({
            flavour = "mocha", -- latte, frappe, macchiato, mocha
            dim_inactive = {
                enabled = false,
                shade = "dark",
                percentage = 0.15,
            },
            integrations = {
                cmp = true,
                dap = true,
                dap_ui = true,
                gitsigns = true,
                harpoon = true,
                mason = true,
                telescope = true,
                treesitter = true,
                treesitter_context = true,
            },
        })
    end,
}
