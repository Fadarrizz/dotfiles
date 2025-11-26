return {
    'windwp/nvim-ts-autotag',
    dependencies = 'nvim-treesitter/nvim-treesitter',
    config = function()
        require('nvim-ts-autotag').setup({
            filetypes = { 'html', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'svelte',
                'vue', 'tsx', 'jsx', 'rescript', 'xml', 'blade', 'php', 'markdown', 'astro', 'glimmer',
                'handlebars', 'hbs',
            },
        })
    end,
}
