local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader> ", mark.toggle_file, { desc = 'toggle marking file' })
vim.keymap.set("n", "H", ui.toggle_quick_menu, { desc = 'toggle harpoon menu' })

vim.keymap.set("n", "<C-H>", function() ui.nav_file(1) end, { desc = 'goto file 1' })
vim.keymap.set("n", "<C-J>", function() ui.nav_file(2) end, { desc = 'goto file 2' })
vim.keymap.set("n", "<C-K>", function() ui.nav_file(3) end, { desc = 'goto file 3' })
vim.keymap.set("n", "<C-L>", function() ui.nav_file(4) end, { desc = 'goto file 4' })
