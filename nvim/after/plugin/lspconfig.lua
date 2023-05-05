local ih = require('inlay-hints')
ih.setup()

local lsp = require('lsp-zero').preset('recommended')

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({ buffer = bufnr })

  local opts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, opts)
end)

lsp.ensure_installed({
  'html',
  'eslint',
  'rust_analyzer',
  'tailwindcss',
  'intelephense',
})

require('lspconfig').lua_ls.setup({
  on_attach = function(client, bufnr)
    ih.on_attach(client, bufnr)
  end,
  settings = {
    Lua = {
      hint = {
        enable = true,
      },
    },
  },
})

-- See: https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/server_configurations/intelephense.lua
lsp.configure('intelephense', {})

lsp.skip_server_setup({ 'rust_analyzer' })

lsp.configure('html', {
  filetypes = { 'html', 'blade', 'handlebars' }
})

-- lsp.on_attach(function (client, bufnr)
--   local opts = { noremap=true, silent=true, buffer=bufnr }

--   vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
--   vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
--   vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
--   vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
--   vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
--   vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
--   vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
--   vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
--   vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
--   vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
--   vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
--   vim.keymap.set('n', '<space>wl', function()
--     print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
--   end, opts)
--   vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
--   vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
--   vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
--   -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
--   vim.keymap.set('n', 'gr', ':Telescope lsp_references<CR>', opts)
--   vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, opts)
-- end)

lsp.setup()

-- CMP
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)
-- END CMP

-- Rust
local rust_tools = require('rust-tools')

rust_tools.setup({
  tools = {
    on_initialized = function()
      ih.set_all()
    end,
    inlay_hints = {
      auto = false,
    },
  },
  server = {
    on_attach = function(client, bufnr)
      ih.on_attach(client, bufnr)
      vim.keymap.set('n', '<leader>ca', rust_tools.hover_actions.hover_actions, { buffer = bufnr })
    end
  }
})
-- END Rust
