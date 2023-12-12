local harpoon = require("harpoon")

harpoon:setup()

vim.keymap.set("n", "<leader> ", function() harpoon:list():append() end, { desc = 'toggle marking file' })
vim.keymap.set("n", "H", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = 'toggle harpoon menu' })

vim.keymap.set("n", "<C-H>", function() harpoon:list():select(1) end, { desc = 'goto file 1' })
vim.keymap.set("n", "<C-J>", function() harpoon:list():select(2) end, { desc = 'goto file 2' })
vim.keymap.set("n", "<C-K>", function() harpoon:list():select(3) end, { desc = 'goto file 3' })
vim.keymap.set("n", "<C-L>", function() harpoon:list():select(4) end, { desc = 'goto file 4' })
