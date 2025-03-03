return {
    { 'sindrets/diffview.nvim' },

    {
        "lewis6991/gitsigns.nvim",
        lazy = false,
        dependencies = { "nvim-lua/plenary.nvim" },
        keys = {
            { ']c', ':Gitsigns next_hunk<CR>' },
            { '[c', ':Gitsigns prev_hunk<CR>' },
            { '<leader>hs', ':Gitsigns stage_hunk<CR>' },
            { '<leader>hr', ':Gitsigns reset_hunk<CR>' },
            { '<leader>hs', function() require('gitsigns').stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end, mode = 'v' },
            { '<leader>hr', function() require('gitsigns').reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end, mode = 'v' },
            { '<leader>hS', ':Gitsigns undo_stage_hunk<CR>' },
            { '<leader>hp', ':Gitsigns preview_hunk<CR>' },
            { '<leader>hb', ':Gitsigns blame_line<CR>' },
          },
        opts = {}
    },

    {
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
}
