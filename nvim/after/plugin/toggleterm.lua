local status, toggleterm = pcall(require, 'toggleterm')
if (not status) then return end

require("toggleterm").setup({
    insert_mappings = true,
    terminal_mappings = true,
    direction = 'vertical',
    -- size = 100,
    -- float_opts = {
    --     border = 'curved',
    --     winblend = 0,
    -- },
    -- persist_size = false,
    -- winbar = {
    --     enable = true
    -- },
    -- auto_scroll = false
})

local Terminal = require('toggleterm.terminal').Terminal

-- Lazygit
local lazygit  = Terminal:new({
    cmd = "lazygit",
    hidden = true,
    direction = "float",
})

function _lazygit_toggle()
    lazygit:toggle()
end

vim.keymap.set({ "n", "t" }, "<leader>lg", function() lazygit:toggle() end, {
    noremap = true,
    silent = true,
    desc = "Toggle Lazygit",
})

-- Default
local floating = Terminal:new({ cmd = "zsh", hidden = true, direction = 'float' })

vim.keymap.set({ "n", "t" }, "<leader>tt", function() floating:toggle() end, {
    noremap = true,
    silent = true,
    desc = "Toggle term",
})
