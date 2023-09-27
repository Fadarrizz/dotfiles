-- This file can be loaded by calling `lua require('plugins')` from your init.vim
-- Only required if you have packer configured as `opt`
vim.cmd.packadd('packer.nvim')

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use 'tpope/vim-commentary'
    use 'tpope/vim-repeat'
    use 'tpope/vim-surround'
    use 'tpope/vim-abolish'       -- working with word variants
    use 'tpope/vim-projectionist' -- per project configuration
    use 'tpope/vim-unimpaired' -- mappings for next/previous, option toggling, en-/decoding, 
    use 'mbbill/undotree'
    use 'folke/which-key.nvim'
    use { 'Wansmer/treesj', requires = { 'nvim-treesitter' } } -- splitjoin
    use 'ThePrimeagen/vim-be-good'
    use 'dbeniamine/cheat.sh-vim'
    use 'jose-elias-alvarez/null-ls.nvim' -- LSP injector (for non-LSP sources)
    use 'nmac427/guess-indent.nvim'
    use 'monaqa/dial.nvim'                -- increment/decrement numbers, dates, true/false, &&/||
    use 'stevearc/dressing.nvim'          -- ui improvements
    use 'anuvyklack/pretty-fold.nvim'
    use { "akinsho/toggleterm.nvim", tag = '*' }

    -- Autopairs
    use {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end,
    }

    -- Autotags (html)
    use {
        'windwp/nvim-ts-autotag',
        requires = 'nvim-treesitter/nvim-treesitter',
        config = function()
            require('nvim-ts-autotag').setup({
                filetypes = {
                    'html',
                    'javascript',
                    'typescript',
                    'javascriptreact',
                    'typescriptreact',
                    'svelte',
                    'vue',
                    'tsx',
                    'jsx',
                    'rescript',
                    'xml',
                    'blade',
                    'php',
                    'markdown',
                    'astro',
                    'glimmer',
                    'handlebars',
                    'hbs',
                },
            })
        end,
    }

    -- Git
    use {
        'lewis6991/gitsigns.nvim',
        requires = 'nvim-lua/plenary.nvim',
    }
    use "sindrets/diffview.nvim"

    -- Testing
    use 'vim-test/vim-test'

    -- Debugging
    use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } }
    use {
        'jayp0521/mason-nvim-dap.nvim',
        requires = { 'williamboman/mason.nvim', run = ':MasonUpdate' },
    }
    use 'theHamsta/nvim-dap-virtual-text'

    -- Lua / Nvim
    use "nvim-lua/plenary.nvim"
    use "folke/neodev.nvim"

    -- Php / Laravel
    use 'jwalton512/vim-blade'
    use {
        'phpactor/phpactor',
        branch = 'master',
        ft = 'php',
        run = 'composer install --no-dev -o',
    }

    -- HTML/XMl
    use {
        'whatyouhide/vim-textobj-xmlattr',
        requires = { 'kana/vim-textobj-user' },
    }

    -- Rust
    use 'neovim/nvim-lspconfig'
    use 'simrat39/rust-tools.nvim'

    -- Database
    use 'tpope/vim-dadbod'
    use 'kristijanhusak/vim-dadbod-ui'

    -- Markdown
    use { 'toppair/peek.nvim', run = 'deno task --quiet build:fast' }

    -- Filetree
    use { 'nvim-tree/nvim-tree.lua', requires = 'nvim-tree/nvim-web-devicons' }

    -- Syntax highlighting
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', requires = {
        'nvim-treesitter/playground',
        'nvim-treesitter/nvim-treesitter-textobjects',
        'JoosepAlviste/nvim-ts-context-commentstring',
    } }

    -- Fuzzy finder
    use { 'nvim-telescope/telescope.nvim', requires = {
        { 'nvim-lua/plenary.nvim' },
        { 'nvim-tree/nvim-web-devicons' },
        { 'BurntSushi/ripgrep' }
    } }

    -- LSP
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            {
                'williamboman/mason.nvim',
                run = ':MasonUpdate',
            },
            { 'williamboman/mason-lspconfig.nvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },

            -- Snippets
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },

            { 'simrat39/inlay-hints.nvim' },
        }
    }

    use { "catppuccin/nvim", as = "catppuccin" }
end)
