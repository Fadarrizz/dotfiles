return {
    'gbprod/substitute.nvim',
    opts = {},
    keys = {
        { 's', function() require('substitute').operator() end, desc = 'Substitute', noremap = true},
        { 'ss', function() require('substitute').line() end, desc = 'Substitute line', noremap = true},
        { 'S', function() require('substitute').eol() end, desc = 'Substitute eol', noremap = true},
        { 's', function() require('substitute').visual() end, ft = 'x', desc = 'Substitute visual', noremap = true},

        { 'sx', function() require('substitute.exchange').operator() end, desc = 'Exchange', noremap = true },
        { 'sxx', function() require('substitute.exchange').line() end, desc = 'Substitute line', noremap = true},
        { 'X', function() require('substitute.exchange').visual() end, ft = 'x', desc = 'Substitute visual', noremap = true},
        { 'sxc', function() require('substitute.exchange').cancel() end, desc = 'Substitute visual', noremap = true},
    },
}
