return {
  "folke/todo-comments.nvim",
  depedencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { "]t", function() require('todo-comments').jump_next() end, "Next todo comment"},
    { "[t", function() require('todo-comments').jump_prev() end, "Previous todo comment"},
    { "<leader>ft", ":TodoTelescope<CR>", "Find todo comments"},
  },
}
