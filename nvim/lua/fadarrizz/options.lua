-- [[ Context ]]
vim.opt.colorcolumn = '120'                              -- str:  Show col for max line length
vim.opt.number = true                                    -- bool: Show line numbers
vim.opt.relativenumber = true                            -- bool: Show relative line numbers
vim.opt.scrolloff = 8                                    -- int:  Min num lines of context
vim.opt.sidescrolloff = 8		                         -- int:  Min num lines of side context
vim.opt.signcolumn = "yes:2"                             -- str:  Show the sign column
vim.opt.cmdheight = 0                                    -- num:  Hide cmd bar when not used

-- [[ Filetypes ]]
vim.opt.encoding = 'UTF8'                                -- str:  String encoding to use
vim.opt.fileencoding = 'UTF8'                            -- str:  File encoding to use

-- [[ Theme ]]
vim.opt.syntax = "ON"                                    -- str:  Allow syntax highlighting
vim.opt.termguicolors = true                             -- bool: If term supports ui color then enable

-- [[ Search ]]
vim.opt.ignorecase = true                                -- bool: Ignore case in search patterns
vim.opt.smartcase = true                                 -- bool: Override ignorecase if search contains capitals
vim.opt.incsearch = true                                 -- bool: Use incremental search
vim.opt.hlsearch = false                                 -- bool: Highlight search matches

-- [[ Whitespace ]]
vim.opt.expandtab = true                                 -- bool: Use spaces instead of tabs
vim.opt.shiftwidth = 4                                   -- num:  Size of an indent
vim.opt.softtabstop = 4                                  -- num:  Number of spaces tabs count for in insert mode
vim.opt.tabstop = 4                                      -- num:  Number of spaces tabs count for
vim.opt.smartindent = true		                         -- bool: Indent based on file type
vim.opt.breakindent = true		                         -- bool: Maintain indentation when wrapping indented lines
vim.opt.autoindent = true                                -- bool: Auto indent
vim.opt.wrap = false

-- [[ Splits ]]
vim.opt.splitright = true                                -- bool: Place new window to right of current one
vim.opt.splitbelow = true                                -- bool: Place new window below the current one

-- [[ Files ]]
vim.opt.swapfile = false                                 -- bool: Allow use of swap file
vim.opt.backup= false                                    -- bool: Allow use of backup
vim.opt.undofile = true                                  -- bool: Allow use of undofile

-- [[ Folding ]]
-- https://www.reddit.com/r/neovim/comments/psl8rq/sexy_folds/
vim.wo.foldmethod = "expr"                              -- str: Use expression as folding method
vim.wo.foldexpr = "nvim_treesitter#foldexpr()"          -- str: Use Treesitter for folding
vim.wo.foldenable = false                               -- bool: Disable folding at startup
vim.opt.foldnestmax = 3                                 -- num: Fold up to n nestings
vim.opt.foldminlines = 1                                -- num: Fold minimum of n line
vim.opt.foldlevelstart = 1                              -- num: Start folding level at n

vim.opt.clipboard = 'unnamedplus'                       -- str: Use system clipboard
vim.opt.updatetime = 50                                 -- num: Make updating fast

-- [[ Completion ]]
-- :help completeopt
-- menuone: popup even when there's only one match
-- noinsert: Do not insert text until a selection is made
-- noselect: Do not select, force to select one from the menu
-- shortmess: avoid showing extra messages when using completion
-- updatetime: set updatetime for CursorHold
vim.opt.completeopt = {'menuone', 'noselect', 'noinsert'}
vim.opt.shortmess = vim.opt.shortmess + { c = true }
