return {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v3.x",
    event = "VeryLazy",
    dependencies = {
        -- LSP Support
        { 'neovim/nvim-lspconfig' },

        -- Manage LSPs from Neovim
        { 'williamboman/mason.nvim' },
        { 'williamboman/mason-lspconfig.nvim' },

        -- Autocompletion
        { 'hrsh7th/nvim-cmp' },
        { 'hrsh7th/nvim-cmp' },
        { 'hrsh7th/cmp-nvim-lsp' },

        -- Snippets
        { 'L3MON4D3/LuaSnip' },
        { 'rafamadriz/friendly-snippets' },

        { 'simrat39/inlay-hints.nvim' },

        {
            'mrcjkb/rustaceanvim',
            version = '^3',
            ft = { 'rust' },
        }
    },
    config = function()
        local lsp = require('lsp-zero')

        lsp.on_attach(function(client, bufnr)
            local map = function(lhs, rhs, desc)
                if desc then
                    desc = "[LSP] " .. desc
                end

                vim.keymap.set("n", lhs, rhs, { noremap = true, silent = true, buffer = bufnr, desc = desc })
            end

            lsp.default_keymaps({ buffer = bufnr })

            map('<leader>f', function() vim.lsp.buf.format { async = true } end, "format")

            map('<leader>ca', vim.lsp.buf.code_action, "code actions")
            map('<leader>rn', vim.lsp.buf.rename, "rename")
            map('gD', vim.lsp.buf.declaration, "go to declaration")
            map('gd', require('telescope.builtin').lsp_definitions, "go to definition")
            map('K', vim.lsp.buf.hover, "show definition")
            map('gi', require('telescope.builtin').lsp_implementations, "go to implementation")
            map('<C-s>', vim.lsp.buf.signature_help, "signature help")
            map('<leader>D', require('telescope.builtin').lsp_type_definitions, "type definition")
            map('gr', require('telescope.builtin').lsp_references, "references")
            map('<leader>ds', require('telescope.builtin').lsp_document_symbols, "document symbols")

            map('<leader>e', vim.diagnostic.open_float, "open diagnostic")
            map('[d', vim.diagnostic.goto_prev, "prev diagnostic")
            map(']d', vim.diagnostic.goto_next, "next diagnostic")
            map('<leader>q', vim.diagnostic.setloclist, "setloclist diagnostic")
        end)

        require('mason').setup({})
        require('mason-lspconfig').setup({
            ensure_installed = { 'html', 'eslint', 'rust_analyzer', 'tailwindcss', 'intelephense' },
            handlers = {
                rust_analyzer = lsp.noop,
                lsp.default_setup,
                lua_ls = function()
                    local lua_opts = lsp.nvim_lua_ls()
                    require('lspconfig').lua_ls.setup(lua_opts)
                end,
            },
        })

        vim.diagnostic.config {
            signs = true,
            underline = true,
            virtual_text = false,
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

        -- Rustaceanvim
        vim.g.rustaceanvim = {
            server = {
                capabilities = lsp.get_capabilities()
            },
        }

        lsp.configure('html', {
            filetypes = { 'html', 'blade', 'handlebars' }
        })

        -- CMP
        local cmp = require('cmp')
        local cmp_action = lsp.cmp_action()
        local cmp_format = lsp.cmp_format()
        local luasnip = require("luasnip")

        local has_words_before = function()
            unpack = unpack or table.unpack
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
        end

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
                --  This will auto-import if the LSP supports it.
                --  This will expand snippets if the LSP sent a snippet.
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),

                -- toggle completion menu
                ['<C-e>'] = cmp_action.toggle_completion(),

                -- select next / prev item in completion menu
                ['<C-n>'] = cmp.mapping.select_next_item(),
                ['<C-p>'] = cmp.mapping.select_prev_item(),

                -- scroll the documentation window back / forward
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),

                -- Manually trigger a completion from nvim-cmp.
                --  Generally you don't need this, because nvim-cmp will display
                --  completions whenever it has completion options available.
                ['<C-Space>'] = cmp.mapping.complete {},

                -- move to the right of snippet expansion
                ['<C-l>'] = cmp.mapping(function()
                    if luasnip.expand_or_locally_jumpable() then
                        luasnip.expand_or_jump()
                    end
                end, { 'i', 's' }),

                -- move to the left of snippet expansion
                ['<C-h>'] = cmp.mapping(function()
                    if luasnip.locally_jumpable(-1) then
                        luasnip.jump(-1)
                    end
                end, { 'i', 's' }),
            }),
        })

        local cmp_autopairs = require('nvim-autopairs.completion.cmp')
        cmp.event:on(
            'confirm_done',
            cmp_autopairs.on_confirm_done()
        )
        -- END CMP
    end
}
