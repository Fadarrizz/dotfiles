-- LEADER/LOCAL
vim.g.mapleader = [[ ]]
vim.g.localleader = [[,]]

-- SKIP REMOTE PROVIDER LOADING
-- vim.g.loaded_python3_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

-- IMPORTS
require('fadarrizz.autocmd')
require('fadarrizz.vars')
require('fadarrizz.options')
require('fadarrizz.keymaps')
require('fadarrizz.plugins')
