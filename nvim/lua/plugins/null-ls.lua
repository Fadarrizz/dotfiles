-- LSP injector (for non-LSP sources)
return {
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
        local null_ls = require('null-ls')

        null_ls.setup({})
    end
}
