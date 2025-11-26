return {
  'phpactor/phpactor',
  build = 'composer install --no-dev --optimize-autoloader',
  ft = 'php',
  keys = {
    { '<Leader>pm', ':PhpactorContextMenu<CR>', desc = 'Phpactor context menu' },
    { '<Leader>pn', ':PhpactorClassNew<CR>', desc = 'Phpactor new class' },
  }

    -- "gbprod/phpactor.nvim",
    -- ft = "php",
    -- dependencies = {
    --   "nvim-lua/plenary.nvim",
    --   "neovim/nvim-lspconfig",
    --   -- If the update/install notification doesn't show properly,
    --   -- you should also add here UI plugins like "folke/noice.nvim" or "stevearc/dressing.nvim"
    -- },
    -- keys = {
    --     { '<Leader>pm', function() require('phpactor').rpc('context_menu', {}) end, desc = 'Phpactor context menu' },
    --     { '<Leader>pn', function() require('phpactor').rpc('new_class', {}) end, desc = 'Phpactor new class' },
    -- }
}
