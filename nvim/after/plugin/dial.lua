local set = vim.keymap.set
local dial = require('dial.map')

set("n", "<C-a>", dial.inc_normal(), {noremap = true, desc = 'Inc normal'})
set("n", "<C-x>", dial.dec_normal(), {noremap = true, desc = 'Dec normal'})
set("n", "g<C-a>", dial.inc_gnormal(), {noremap = true, desc = 'Inc g normal'})
set("n", "g<C-x>", dial.dec_gnormal(), {noremap = true, desc = 'Dec g normal'})
set("v", "<C-a>", dial.inc_visual(), {noremap = true, desc = 'Inc visual'})
set("v", "<C-x>", dial.dec_visual(), {noremap = true, desc = 'Dec visual'})
set("v", "g<C-a>",dial.inc_gvisual(), {noremap = true, desc = 'Inc g visual'})
set("v", "g<C-x>",dial.dec_gvisual(), {noremap = true, desc = 'Dec g visual'})
