return {
    "neovim/nvim-lspconfig",
    dependencies = {
        { 'williamboman/mason.nvim' },
        { 'williamboman/mason-lspconfig.nvim' },
        { 'hrsh7th/nvim-cmp' },
        { 'hrsh7th/cmp-path' },
        { 'hrsh7th/cmp-buffer' },
        { 'hrsh7th/cmp-cmdline' },
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'L3MON4D3/LuaSnip' },
        { "rafamadriz/friendly-snippets" },
        { "saadparwaiz1/cmp_luasnip" },
        { "j-hui/fidget.nvim" },
    },
    config = function()
        local cmp = require('cmp')
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities())

        require("fidget").setup({})
        require('mason').setup()
        require('mason-lspconfig').setup({
            automatic_installation = true,
            ensure_installed = { 'html', 'eslint', 'intelephense', 'rust_analyzer', 'tailwindcss', 'dockerls', 'gopls', 'jsonls', 'bashls' },
            handlers = {
                function(server_name)
                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities
                    }
                end,

                ["lua_ls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.lua_ls.setup {
                        settings = {
                            Lua = {
                                diagnostics = {
                                    globals = { "vim" }
                                }
                            }
                        }
                    }
                end,

                ["html"] = function()
                    require("lspconfig").html.setup {
                        capabilities = capabilities,
                        filetypes = {
                            'antlers.html', 'antlers', 'blade.html.php', 'blade', 'html',
                        }
                    }
                end,

                ["phpactor"] = function()
                    require("lspconfig").phpactor.setup {
                        filetypes = { "php", "blade" },
                        init_options = {
                            ["language_server.diagnostics_on_update"] = false,
                            ["language_server.diagnostics_on_open"] = false,
                            ["language_server.diagnostics_on_save"] = false,
                            ["language_server_phpstan.enabled"] = true,
                            ["language_server_psalm.enabled"] = false,
                        }
                    }
                end
            },
        })

        require("luasnip.loaders.from_vscode").lazy_load()

        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
            preselect = 'item',
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' }, -- For luasnip users.
            }, {
                { name = 'buffer' },
            })
        })

        local cmp_autopairs = require('nvim-autopairs.completion.cmp')
        cmp.event:on(
            'confirm_done',
            cmp_autopairs.on_confirm_done()
        )
    end
}
