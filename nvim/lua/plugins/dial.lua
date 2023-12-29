-- increment/decrement numbers, dates, true/false, &&/||
return {
    "monaqa/dial.nvim",
    keys = {
        { "<C-a>", function () require('dial.map').inc_normal() end, 'Inc normal'},
        { "<C-x>", function () require('dial.map').dec_normal() end, 'Dec normal'},
        { "g<C-a>", function () require('dial.map').inc_gnormal() end, 'Inc g normal'},
        { "g<C-x>", function () require('dial.map').dec_gnormal() end, 'Dec g normal'},
        { "<C-a>", function () require('dial.map').inc_visual() end, 'Inc visual'},
        { "<C-x>", function () require('dial.map').dec_visual() end, 'Dec visual'},
        { "g<C-a>", function () require('dial.map').inc_gvisual() end, 'Inc g visual'},
        { "g<C-x>", function () require('dial.map').dec_gvisual() end, 'Dec g visual'},
    }
}
