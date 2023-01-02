local opt = vim.opt

-- [[ Context ]]
opt.colorcolumn = '120'                             -- str:  Show col for max line length
opt.number = true                                   -- bool: Show line numbers
opt.relativenumber = true                           -- bool: Show relative line numbers
opt.scrolloff = 8                                   -- int:  Min num lines of context
opt.sidescrolloff = 8		                        -- int:  Min num lines of side context
opt.signcolumn = "yes"                              -- str:  Show the sign column

-- [[ Filetypes ]]
opt.encoding = 'utf8'                               -- str:  String encoding to use
opt.fileencoding = 'utf8'                            -- str:  File encoding to use

-- [[ Theme ]]
opt.syntax = "ON"                                    -- str:  Allow syntax highlighting
opt.termguicolors = true                             -- bool: If term supports ui color then enable

-- [[ Search ]]
opt.ignorecase = true                                -- bool: Ignore case in search patterns
opt.smartcase = true                                 -- bool: Override ignorecase if search contains capitals
opt.incsearch = true                                 -- bool: Use incremental search
opt.hlsearch = false                                 -- bool: Highlight search matches

-- [[ Whitespace ]]
opt.expandtab = true                                 -- bool: Use spaces instead of tabs
opt.shiftwidth = 4                                   -- num:  Size of an indent
opt.softtabstop = 4                                  -- num:  Number of spaces tabs count for in insert mode
opt.tabstop = 4                                      -- num:  Number of spaces tabs count for
opt.smartindent = true		                         -- bool: Indent based on file type
opt.breakindent = true		                         -- bool: Maintain indentation when wrapping indented lines
opt.wrap = false

-- [[ Splits ]]
opt.splitright = true                                -- bool: Place new window to right of current one
opt.splitbelow = true                                -- bool: Place new window below the current one

-- [[ Files ]]
opt.swapfile = false                                 -- bool: Allow use of swap file
opt.backup= false                                    -- bool: Allow use of backup
opt.undofile = true                                  -- bool: Allow use of undofile

-- [[ Folding ]] https://www.reddit.com/r/neovim/comments/psl8rq/sexy_folds/
opt.foldmethod = "expr"                             -- str: Use expression as folding method
opt.foldexpr = "nvim_treesitter#foldexpr()"         -- str: Use Treesitter for folding
opt.foldtext =                                      -- func: Show fold as indented comment
    [[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').'...'.trim(getline(v:foldend)) ]]
opt.fillchars = "fold: "                            -- str: Fill with empty spaces
opt.foldnestmax = 3                                 -- num: Fold up to 3 nestings
opt.foldminlines = 1                                -- num: Fold minimum of 1 line

opt.clipboard = 'unnamedplus'                         -- str: Use system clipboard

opt.updatetime = 50                                   -- num: Make updating fast

-- Highlight yank
vim.cmd[[au TextYankPost * silent! lua vim.highlight.on_yank()]]
