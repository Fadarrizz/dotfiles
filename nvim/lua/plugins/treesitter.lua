return {
    "nvim-treesitter/nvim-treesitter",
    build = function()
        require('nvim-treesitter.install').update({ with_sync = true })
    end,
    opts = {
        ensure_installed = 'all',
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
        textobjects = {
            select = {
                enable = true,
                lookahead = true,
                keymaps = {
                    ['if'] = '@function.inner',
                    ['af'] = '@function.outer',
                    ['ic'] = '@class.inner',
                    ['ac'] = '@class.outer',
                    ['il'] = '@loop.inner',
                    ['al'] = '@loop.outer',
                    ['ia'] = '@parameter.inner',
                    ['aa'] = '@parameter.outer',
                },
            },
        },
        autotag = { -- 'windwp/nvim-ts-autotag'
            enable = true,
        },
        endwise = { -- 'RRethy/nvim-treesitter-endwise',
            enable = true,
        },
    },
    config = function(_, opts)
        require('nvim-treesitter.configs').setup(opts)

        local parser_config = require('nvim-treesitter.parsers').get_parser_configs()

        parser_config.blade = {
            install_info = {
                url = "https://github.com/EmranMR/tree-sitter-blade",
                files = { "src/parser.c" },
                branch = "main",
            },
            filetype = "blade"
        }

        vim.filetype.add({
            pattern = {
                ['.*%.blade%.php'] = 'blade',
            },
        })
    end,
    dependencies = {
        'nvim-treesitter/nvim-treesitter-textobjects',
        'nvim-treesitter/nvim-treesitter-context',
        'JoosepAlviste/nvim-ts-context-commentstring',
        'windwp/nvim-ts-autotag',
        'RRethy/nvim-treesitter-endwise',
    },
}
