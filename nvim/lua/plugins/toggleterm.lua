return {
    "akinsho/toggleterm.nvim",
    version = '*',
    opts = {
        start_in_insert = true,
        insert_mappings = true,
        terminal_mappings = true,
        direction = 'vertical',
    },
    keys = {
        {"<leader>tt", "<cmd>ToggleTerm<cr>", 'Toggle main term', {"n", "t"}},
        {"<leader>tt", "<cmd>ToggleTerm<cr>", 'Toggle main term', {"n", "t"}},
    },
    config = true,
}
