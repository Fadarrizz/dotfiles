local vim = vim
local g = vim.g

-- LEADER/LOCAL
g.mapleader = [[ ]]
g.localleader = [[,]]

-- SKIP REMOTE PROVIDER LOADING
g.loaded_python3_provider = 0
g.loaded_node_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0

-- DISABLE UNWANTED PLUGINS
local disabled_built_ins = {
    'netrw',
    'netrwPlugin',
}

for i  = 1,1 do
    g['loaded_' .. disabled_built_ins[i]] = 1
end

-- IMPORTS
require('fadarrizz.plugins')
require('fadarrizz.vars')
require('fadarrizz.options')
require('fadarrizz.keymaps')
