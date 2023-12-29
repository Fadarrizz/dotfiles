return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'nvim-telescope/telescope-live-grep-args.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  },
  keys = {
    { '<leader>ff', function() require('telescope.builtin').find_files() end, 'Find files' },
    { '<leader>fa', function() require('telescope.builtin').find_files({ no_ignore = true, prompt_title = 'Find All Files' }) end, 'Find all files' },
    { '<leader>fg', function() require('telescope').extensions.live_grep_args.live_grep_args() end, 'Find in live grep' },
    { '<leader>fG', function() require('telescope.utils').buffer_dir() end, 'Find in all live grep' },
    { '<leader>fo', function() require('telescope.builtin').buffers() end, 'Find buffer' },
    { '<leader>fo', function() require('telescope.builtin').oldfiles() end, 'Find old files' },
    { '<leader>fs', function() require('telescope.builtin').lsp_document_symbols() end, 'Find in file' },
    { '<leader>fr', function() require('telescope.builtin').resume() end, 'Resume previous picker' },
    { '<leader>fq', function() require('telescope.builtin').quickfix() end, 'Find quickfix' },
  },
  config = function ()
    require('telescope').setup {
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
    }
    end
}
