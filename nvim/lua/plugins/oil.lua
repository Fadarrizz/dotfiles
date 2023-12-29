return {
    "stevearc/oil.nvim",
    config = function()
        require("oil").setup()
    end,
    keys = { "-", "<CMD>Oil<CR>", "Open parent directory" },
}
