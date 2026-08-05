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
            cmp_lsp.default_capabilities()
        )

        require("fidget").setup({})
        require('mason').setup()

        -- NOTE: mason-lspconfig.nvim v2+ removed the `handlers`/
        -- `automatic_installation` options used previously. Installed
        -- servers are now auto-enabled via the native `vim.lsp.enable()`
        -- mechanism, so per-server overrides must go through
        -- `vim.lsp.config()` instead of a `handlers` table.

        -- Apply default capabilities (nvim-cmp completion support) to every server.
        vim.lsp.config('*', {
            capabilities = capabilities,
        })

        vim.lsp.config('lua_ls', {
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { "vim" }
                    }
                }
            }
        })

        vim.lsp.config('html', {
            filetypes = {
                'antlers.html', 'antlers', 'blade.html.php', 'blade', 'html',
            }
        })

        vim.lsp.config('phpactor', {
            filetypes = { "php", "blade" },
            init_options = {
                ["language_server.diagnostics_on_update"] = false,
                ["language_server.diagnostics_on_open"] = false,
                ["language_server.diagnostics_on_save"] = false,
                ["language_server_phpstan.enabled"] = false,
                ["language_server_psalm.enabled"] = false,
            }
        })

        require('mason-lspconfig').setup({
            ensure_installed = { 'html', 'eslint', 'intelephense', 'rust_analyzer', 'tailwindcss', 'dockerls', 'gopls', 'jsonls', 'bashls', 'pyright', 'kotlin_lsp' },
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
