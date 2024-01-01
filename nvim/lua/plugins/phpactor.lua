return {
  'phpactor/phpactor',
  build = 'composer install --no-dev --optimize-autoloader',
  ft = 'php',
  keys = {
    { '<Leader>pm', ':PhpactorContextMenu<CR>', desc = 'Phpactor context menu' },
    { '<Leader>pn', ':PhpactorClassNew<CR>', desc = 'Phpactor new class' },
  }
}
