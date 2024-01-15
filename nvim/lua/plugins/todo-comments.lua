return {
    "folke/todo-comments.nvim",
    lazy = false,
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
        { "]t", function() require('todo-comments').jump_next() end, desc = "Next todo comment" },
        { "[t", function() require('todo-comments').jump_prev() end, desc = "Previous todo comment" },
        { "<leader>ft", ":TodoTelescope<CR>", desc = "Find todo comments" },
    },
    opts = {},
}
