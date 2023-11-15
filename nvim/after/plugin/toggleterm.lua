local status, toggleterm = pcall(require, 'toggleterm')
if (not status) then return end

require("toggleterm").setup({
    start_in_insert = true,
    insert_mappings = true,
    terminal_mappings = true,
    direction = 'vertical',
})

local Terminal = require('toggleterm.terminal').Terminal

-- Default
local floating = Terminal:new({ cmd = "zsh", hidden = true, direction = 'float' })
local floating2 = Terminal:new({ cmd = "zsh", hidden = true, direction = 'float' })

vim.keymap.set({ "n", "t" }, "<leader>tt", function() floating:toggle() end, {
    noremap = true,
    silent = true,
    desc = "Toggle main term",
})

vim.keymap.set({ "n", "t" }, "<leader>t2", function() floating2:toggle() end, {
    noremap = true,
    silent = true,
    desc = "Toggle 2nd term",
})
