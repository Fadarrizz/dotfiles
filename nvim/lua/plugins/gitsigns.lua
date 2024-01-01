return {
    "lewis6991/gitsigns.nvim",
    lazy = false,
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
        { ']c', ':Gitsigns next_hunk<CR>' },
        { '[c', ':Gitsigns prev_hunk<CR>' },
        { 'hs', ':Gitsigns stage_hunk<CR>' },
        { 'hr', ':Gitsigns reset_hunk<CR>' },
        { 'hs', function() require('gitsigns').stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end, mode = 'v' },
        { 'hr', function() require('gitsigns').reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end, mode = 'v' },
        { 'hS', ':Gitsigns undo_stage_hunk<CR>' },
        { 'hp', ':Gitsigns preview_hunk<CR>' },
        { 'hb', ':Gitsigns blame_line<CR>' },
      },
    opts = {}
}
