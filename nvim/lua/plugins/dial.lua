-- increment/decrement numbers, dates, true/false, &&/||
return {
    "monaqa/dial.nvim",
    keys = {
        { "<C-a>", function () require('dial.map').inc_normal() end, desc = 'Inc normal'},
        { "<C-x>", function () require('dial.map').dec_normal()  end, desc = 'Dec normal'},
        { "g<C-a>", function () require('dial.map').inc_gnormal()  end, desc = 'Inc g normal'},
        { "g<C-x>", function () require('dial.map').dec_gnormal()  end, desc = 'Dec g normal'},
        { "<C-a>", function () require('dial.map').inc_visual()  end, desc = 'Inc visual'},
        { "<C-x>", function () require('dial.map').dec_visual()  end, desc = 'Dec visual'},
        { "g<C-a>", function () require('dial.map').inc_gvisual()  end, desc = 'Inc g visual'},
        { "g<C-x>", function () require('dial.map').dec_gvisual()  end, desc = 'Dec g visual'},
    }
}
