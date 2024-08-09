return {
    "kdheepak/lazygit.nvim",
    cmd = {
        "LazyGit",
        "LazyGitConfig",
        "LazyGitCurrentFile",
        "LazyGitFilter",
        "LazyGitFilterCurrentFile",
    },
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
        { "<leader>lg", ":LazyGit<CR>", desc = 'Toggle LazyGit' },
        { "<leader>lc", ":LazyGitCurrentFile<CR>", desc = 'Toggle LazyGit Current File' },
        { "<leader>lf", ":LazyGitFilterCurrentFile<CR>", desc = 'Filter LazyGit Current File' },
    },
}
