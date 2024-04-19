  return {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("refactoring").setup()
    end,
    keys = {
        { "<leader>re", ":Refactor extract " , mode = "x", desc = 'Refactor extract'},
        { "<leader>rf", ":Refactor extract_to_file " , mode = "x", desc = 'Refactor extract to file'},
        { "<leader>rv", ":Refactor extract_var ", mode = "x", desc = 'Refactor extract variable' },
        { "<leader>ri", ":Refactor inline_var", mode = {"n", "x"}, desc = 'Refactor inline variable'},
        { "<leader>rI", ":Refactor inline_func", mode = "n", desc = 'Refactor inline function' },
        { "<leader>rb", ":Refactor extract_block", mode = "n", desc = 'Refactor extract block' },
        { "<leader>rbf", ":Refactor extract_block_to_file", mode = "n", desc = 'Refactor extract bolk to file' },
      },
  }
