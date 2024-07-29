-- Disabled due to nvim v0.10 issues
-- https://github.com/anuvyklack/pretty-fold.nvim/issues/39
return {
    "anuvyklack/pretty-fold.nvim",
    enable = false,
    config = function()
        require('pretty-fold').setup {
            fill_char = ' ',
        }
    end
}

