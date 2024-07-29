return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  keys = {
    { '<leader>ff', function() require('telescope.builtin').find_files() end, desc = 'Find files' },
    { '<leader>fa', function() require('telescope.builtin').find_files({ no_ignore = true, prompt_title = 'Find All Files' }) end, desc = 'Find all files' },
    { '<leader>fg', function() require('telescope.builtin').live_grep() end, desc = 'Find in live grep' },
    { '<leader>fG', function() require('telescope.builtin').live_grep({ no_ignore = true, prompt_title = 'Find All Live Grep' }) end, desc = 'Find in all live grep' },
    { '<leader>fb', function() require('telescope.builtin').buffers() end, desc = 'Find buffer' },
    { '<leader>fo', function() require('telescope.builtin').oldfiles() end, desc = 'Find old files' },
    { '<leader>fr', function() require('telescope.builtin').resume() end, desc = 'Resume previous picker' },
    { '<leader>fq', function() require('telescope.builtin').quickfix() end, desc = 'Find quickfix' },
    { '<leader>fh', function() require('telescope.builtin').help_tags() end, desc = 'Find help tags' },
    { '<leader>fk', function() require('telescope.builtin').keymaps() end, desc = 'Find keymaps' },
    { '<leader>fs', function() require('telescope.builtin').builtin() end, desc = 'Find in Telescope' },
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
