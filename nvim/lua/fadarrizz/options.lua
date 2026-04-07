-- [[ Leader ]]
vim.g.mapleader = ' '
vim.g.localleader = ' '

vim.g.have_nerd_font = true

-- [[ Context ]]
vim.o.colorcolumn = '120'                                       -- str:  Show col for max line length
vim.o.number = true                                             -- bool: Show line numbers
vim.o.relativenumber = true                                     -- bool: Show relative line numbers
vim.o.scrolloff = 8                                             -- int:  Min num lines of context
vim.o.sidescrolloff = 8		                                    -- int:  Min num lines of side context
vim.o.signcolumn = "yes"                                        -- str:  Show the sign column
vim.o.cmdheight = 0                                             -- num:  Hide cmd bar when not used

-- [[ Filetypes ]]
vim.o.encoding = 'UTF8'                                         -- str:  String encoding to use
vim.o.fileencoding = 'UTF8'                                     -- str:  File encoding to use
vim.filetype.add({
    pattern = {
        -- ['.*%.blade%.php'] = 'blade',
        ['.*%.antlers%.html'] = 'antlers.html',
    },
})

-- [[ Theme ]]
vim.o.syntax = "ON"                                             -- str:  Allow syntax highlighting
vim.o.termguicolors = true                                      -- bool: If term supports ui color then enable

-- [[ Search ]]
vim.o.ignorecase = true                                         -- bool: Ignore case in search patterns
vim.o.smartcase = true                                          -- bool: Override ignorecase if search contains capitals
vim.o.incsearch = true                                          -- bool: Use incremental search
vim.o.hlsearch = false                                          -- bool: Highlight search matches

-- [[ Whitespace ]]
vim.o.expandtab = true                                          -- bool: Use spaces instead of tabs
vim.o.shiftwidth = 4                                            -- num:  Size of an indent
vim.o.softtabstop = 4                                           -- num:  Number of spaces tabs count for in insert mode
vim.o.tabstop = 4                                               -- num:  Number of spaces tabs count for
vim.o.smartindent = true		                                -- bool: Indent based on file type
vim.o.breakindent = true		                                -- bool: Maintain indentation when wrapping indented lines
vim.o.autoindent = true                                         -- bool: Auto indent
vim.o.wrap = false

-- [[ Splits ]]
vim.o.splitright = true                                         -- bool: Place new window to right of current one
vim.o.splitbelow = true                                         -- bool: Place new window below the current one

-- [[ Files ]]
vim.o.swapfile = false                                          -- bool: Allow use of swap file
vim.o.backup = false                                            -- bool: Allow use of backup
vim.o.undofile = true                                           -- bool: Allow use of undofile
vim.o.autoread = true                                           -- bool: Automatically reread changed files

-- [[ Folding ]]
-- https://www.reddit.com/r/neovim/comments/psl8rq/sexy_folds/
vim.o.foldmethod = "expr"                                       -- str: Use expression as folding method
vim.o.foldexpr = "nvim_treesitter#foldexpr()"                   -- str: Use Treesitter for folding
vim.o.foldenable = false                                        -- bool: Disable folding at startup
vim.o.foldnestmax = 3                                           -- num: Fold up to n nestings
vim.o.foldminlines = 1                                          -- num: Fold minimum of n line
vim.o.foldlevelstart = 1                                        -- num: Start folding level at n

vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)    -- str: Use system clipboard
vim.o.updatetime = 250                                          -- num: Make updating fast
vim.o.timeoutlen = 300                                          -- num: Decrease mapped sequence wait time 

-- [[ Completion ]]
-- :help completeopt
-- menuone: popup even when there's only one match
-- noinsert: Do not insert text until a selection is made
-- noselect: Do not select, force to select one from the menu
-- shortmess: avoid showing extra messages when using completion
-- updatetime: set updatetime for CursorHold
vim.opt.completeopt = {'menuone', 'noselect', 'noinsert'}
vim.opt.shortmess = vim.opt.shortmess + { c = true }

-- [[ Diagnostics ]]
vim.diagnostic.config({
    float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
    },
})

-- [[ Remote Providers ]]
vim.g.loaded_python3_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
