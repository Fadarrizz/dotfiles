-- LEADER/LOCAL
vim.g.mapleader = [[ ]]
vim.g.localleader = [[,]]

-- SKIP REMOTE PROVIDER LOADING
vim.g.loaded_python3_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0


-- DISABLE UNWANTED PLUGINS
-- local disabled_built_ins = {
--     'netrw',
--     'netrwPlugin',
-- }

-- for i  = 1,1 do
--     vim.g['loaded_' .. disabled_built_ins[i]] = 1
-- end

-- function R(name)
--     require("plenary.reload").reload_module(name)
-- end

-- IMPORTS
require('fadarrizz.autocmd')
require('fadarrizz.plugins')
require('fadarrizz.vars')
require('fadarrizz.options')
require('fadarrizz.keymaps')
