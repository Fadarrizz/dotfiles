require('todo-comments').setup({})

vim.keymap.set("n", "]t", function()
  require("todo-comments").jump_next()
end, { desc = "Next todo comment" })

vim.keymap.set("n", "[t", function()
  require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })

vim.keymap.set("n", "[t", function()
  require("todo-comments").todo()
end, { desc = "Previous todo comment" })

vim.keymap.set('n', '<leader>ft', ':TodoTelescope<CR>', { desc = "Find todo comments" })
