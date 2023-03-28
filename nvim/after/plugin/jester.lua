local jester = require("jester")

jester.setup({
    cmd = "npm test -t '$result' -- '$file'"
})

vim.keymap.set('n', '<leader>tdr', jester.run, {})
vim.keymap.set('n', '<leader>tdn', jester.debug, {})
vim.keymap.set('n', '<leader>tdl', jester.debug_last, {})
