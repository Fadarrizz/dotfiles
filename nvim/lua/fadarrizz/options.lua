-- [[ Context ]]
vim.opt.colorcolumn = '120'                              -- str:  Show col for max line length
vim.opt.number = true                                    -- bool: Show line numbers
vim.opt.relativenumber = true                            -- bool: Show relative line numbers
vim.opt.scrolloff = 8                                    -- int:  Min num lines of context
vim.opt.sidescrolloff = 8		                         -- int:  Min num lines of side context
vim.opt.signcolumn = "yes"                               -- str:  Show the sign column
vim.opt.cmdheight = 0                                    -- num:  Hide cmd bar when not used

-- [[ Filetypes ]]
vim.opt.encoding = 'utf8'                                -- str:  String encoding to use
vim.opt.fileencoding = 'utf8'                            -- str:  File encoding to use

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
vim.opt.foldmethod = "expr"                             -- str: Use expression as folding method
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"         -- str: Use Treesitter for folding
vim.opt.foldtext =                                      -- func: Show fold as indented comment
    [[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').'...'.trim(getline(v:foldend)) ]]
vim.opt.fillchars = "fold: ,eob: "                      -- str: Fill with empty spaces for fold and eob
vim.opt.foldnestmax = 3                                 -- num: Fold up to 3 nestings
vim.opt.foldminlines = 1                                -- num: Fold minimum of 1 line
---WORKAROUND
-- vim.api.nvim_create_autocmd({'BufEnter','BufAdd','BufNew','BufNewFile','BufWinEnter'}, {
--     group = vim.api.nvim_create_augroup('TS_FOLD_WORKAROUND', {}),
--     callback = function()
--         vim.opt.foldmethod = 'expr'
--         vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
--         vim.opt.foldtext =
--             [[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').'...'.trim(getline(v:foldend)) ]]
--         vim.opt.fillchars = "fold: ,eob: "
--         vim.opt.foldnestmax = 3
--         vim.opt.foldminlines = 1
--     end
-- })
---ENDWORKAROUND

vim.opt.clipboard = 'unnamedplus'                       -- str: Use system clipboard

vim.opt.updatetime = 50                                 -- num: Make updating fast

-- Highlight yank
vim.cmd[[au TextYankPost * silent! lua vim.highlight.on_yank()]]
