-- Disabled due to nvim v0.10 issues
-- https://github.com/anuvyklack/pretty-fold.nvim/issues/39
return {
    "bbjornstad/pretty-fold.nvim",
    config = function()
        require('pretty-fold').setup {
            fill_char = ' ',
        }
    end
}

