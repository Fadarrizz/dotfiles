require('peek').setup()

vim.keymap.set(
    'n',
    '<leader>op',
    function()
      local peek = require("peek")
      if peek.is_open() then
        peek.close()
      else
        peek.open()
      end
    end,
    { desc = "Peek (Markdown Preview)" }
)

