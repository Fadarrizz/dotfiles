return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'nvim-telescope/telescope-live-grep-args.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  },
  keys = {
    { '<leader>ff', function() require('telescope.builtin').find_files() end, desc = 'Find files' },
    { '<leader>fa', function() require('telescope.builtin').find_files({ no_ignore = true, prompt_title = 'Find All Files' }) end, desc = 'Find all files' },
    { '<leader>fg', function() require('telescope').extensions.live_grep_args.live_grep_args() end, desc = 'Find in live grep' },
    { '<leader>fG', function() require('telescope.utils').buffer_dir() end, desc = 'Find in all live grep' },
    { '<leader>fo', function() require('telescope.builtin').buffers() end, desc = 'Find buffer' },
    { '<leader>fo', function() require('telescope.builtin').oldfiles() end, desc = 'Find old files' },
    { '<leader>fd', function() require('telescope.builtin').lsp_document_symbols() end, desc = 'lsp document symbols' },
    { '<leader>fs', function() require('telescope.builtin').lsp_workspace_symbols() end, desc = 'lsp workspace symbols' },
    { '<leader>fr', function() require('telescope.builtin').resume() end, desc = 'Resume previous picker' },
    { '<leader>fq', function() require('telescope.builtin').quickfix() end, desc = 'Find quickfix' },
  },
  opts = {
    defaults = {
      path_display = { truncate = 1 },
      file_ignore_patterns = { '.git/' },
    },
    pickers = {
      find_files = {
        hidden = true,
      },
      buffers = {
        previewer = false,
        layout_config = {
          width = 80,
        },
        sort_lastused = true,
      },
      lsp_references = {
        previewer = false,
      },
    },
  },
}
