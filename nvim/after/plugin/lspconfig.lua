local lsp = require('lsp-zero')

lsp.on_attach(function(client, bufnr)
  local map = function(lhs, rhs, desc)
    if desc then
      desc = "[LSP] " .. desc
    end

    vim.keymap.set("n", lhs, rhs, { noremap = true, silent = true, buffer = bufnr, desc = desc })
  end

  lsp.default_keymaps({ buffer = bufnr })

  map('<space>e', vim.diagnostic.open_float, "open diagnostic")
  map('<space>ca', vim.lsp.buf.code_action, "code actions")
  map('<space>f', function() vim.lsp.buf.format { async = true } end, "format")
  map('<space>rn', vim.lsp.buf.rename, "rename")
  map('[d', vim.diagnostic.goto_prev, "prev diagnostic")
  map(']d', vim.diagnostic.goto_next, "next diagnostic")
  map('<space>q', vim.diagnostic.setloclist, "setloclist diagnostic")
  map('gD', vim.lsp.buf.declaration, "go to declaration")
  map('gd', vim.lsp.buf.definition, "go to definition")
  map('K', vim.lsp.buf.hover, "show definition")
  map('gi', vim.lsp.buf.implementation, "go to implementation")
  map('<C-s>', vim.lsp.buf.signature_help, "signature help")
  map('<space>D', vim.lsp.buf.type_definition, "type definition")
  map('gr', vim.lsp.buf.references, "references")
end)

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = { 'html', 'eslint', 'rust_analyzer', 'tailwindcss', 'intelephense' },
  handlers = {
    lsp.default_setup,
    lua_ls = function()
      local lua_opts = lsp.nvim_lua_ls()
      require('lspconfig').lua_ls.setup(lua_opts)
    end,
  },
})

vim.diagnostic.config {
  virtual_text = false,
  signs = true,
  underline = true,
}

-- Intelephense
-- See: https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/server_configurations/intelephense.lua
lsp.configure('intelephense', {})

-- Phpactor
require('lspconfig').phpactor.setup {
  root_dir = function(_)
    return vim.loop.cwd()
  end,
  init_options = {
    ["language_server.diagnostics_on_update"] = false,
    ["language_server.diagnostics_on_open"] = false,
    ["language_server.diagnostics_on_save"] = false,
    ["language_server_phpstan.enabled"] = true,
    ["language_server_psalm.enabled"] = false,
  }
}

local rust_tools = require('rust-tools')

rust_tools.setup({
  server = {
    on_attach = function(_, bufnr)
      vim.keymap.set('n', '<leader>ca', rust_tools.hover_actions.hover_actions, {buffer = bufnr, desc = "code actions"})
    end
  },
})

lsp.configure('html', {
  filetypes = { 'html', 'blade', 'handlebars' }
})

-- CMP
local cmp = require('cmp')
local cmp_action = lsp.cmp_action()
local cmp_format = lsp.cmp_format()

cmp.setup({
  formatting = cmp_format,
  preselect = 'item',
  completion = {
    completeopt = 'menu,menuone,noinsert'
  },
  window = {
    documentation = cmp.config.window.bordered(),
  },
  sources = {
    { name = 'path' },
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
    { name = 'buffer',  keyword_length = 3 },
    { name = 'luasnip', keyword_length = 2 },
  },
  mapping = cmp.mapping.preset.insert({
    -- confirm completion item
    ['<CR>'] = cmp.mapping.confirm({ select = false }),

    -- toggle completion menu
    ['<C-e>'] = cmp_action.toggle_completion(),

    -- tab complete
    ['<Tab>'] = cmp_action.tab_complete(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),

    -- navigate between snippet placeholder
    ['<C-d>'] = cmp_action.luasnip_jump_forward(),
    ['<C-b>'] = cmp_action.luasnip_jump_backward(),

    -- scroll documentation window
    ['<C-f>'] = cmp.mapping.scroll_docs(-5),
    ['<C-u>'] = cmp.mapping.scroll_docs(5),
  }),
})

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)
-- END CMP
