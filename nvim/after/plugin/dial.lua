local set = vim.keymap.set

set("n", "<C-a>", require('dial.map').inc_normal(), {noremap = true, desc = 'Inc normal'})
set("n", "<C-x>", require('dial.map').dec_normal(), {noremap = true, desc = 'Dec normal'})
set("n", "g<C-a>", require('dial.map').inc_gnormal(), {noremap = true, desc = 'Inc g normal'})
set("n", "g<C-x>", require('dial.map').dec_gnormal(), {noremap = true, desc = 'Dec g normal'})
set("v", "<C-a>", require('dial.map').inc_visual(), {noremap = true, desc = 'Inc visual'})
set("v", "<C-x>", require('dial.map').dec_visual(), {noremap = true, desc = 'Dec visual'})
set("v", "g<C-a>",require('dial.map').inc_gvisual(), {noremap = true, desc = 'Inc g visual'})
set("v", "g<C-x>",require('dial.map').dec_gvisual(), {noremap = true, desc = 'Dec g visual'})
