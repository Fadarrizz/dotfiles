"---------- GENERAL ----------"
set nocompatible														"We want the latest Vim settings
set backspace=indent,eol,start						    							"Make backspace behave like every other editor
set backup
set history=200
set ruler
set autoread
set smarttab
set noswapfile															" No swap files
set hidden  															" Allow switching buffers without writing to disk

let mapleader = ','														" Make comma the leader key

"---------- PLUGINS ----------" 
so ~/nvim/plugins.vim

"---------- VISUALS ----------" 
if (has("termguicolors"))
 set termguicolors
endif

syntax enable
let g:airline_theme='oceanicnext'
colorscheme OceanicNext

set number							    								"Line numbers.
set autoindent
set shiftwidth=4						    								" Indendting is 4 spaces, not 8 (should be the same as softtabsstop for consistency)
set softtabstop=4														" Number of spaces inserted when inputting tab

"---------- FINDING FILES ----------"

" Search down into subfolders
" Provides tab-completion for all file-related tasks
set path+=**

set wildignore+=**/node_modules/**

" Display all matching files when we tab complete
set wildmenu

" NOW WE CAN:
" - Hit tab to :find by partial match
" - Use * to make it fuzzy

" THINGS TO CONSIDER:
" - :b lets you autocomplete any open buffer

"---------- SEARCH ----------"
set hlsearch
set incsearch

"---------- TABS ----------"
set splitbelow
set splitright

nmap <C-J> <C-W><C-J>
nmap <C-K> <C-W><C-K>
nmap <C-H> <C-W><C-H>
nmap <C-L> <C-W><C-L>

"---------- MAPPINGS ----------"
"Edit Vimrc file.
nmap <Leader>ev :tabedit $MYVIMRC<CR>
nmap <Leader>ep :e ~/nvim/plugins.vim<CR>

" Open/close Nerdtree
nnoremap <Leader>f :NERDTreeToggle<Enter>

"Disable search highlighting
nmap <Leader><space> :nohlsearch<CR>

"nmap <Leader>o :Files<CR> 
"nmap <Leader>e :History<CR>

"---------- AUTO-COMMANDS ----------"
augroup mygroup
	autocmd!
	" Auto source Vimrc file.
	autocmd BufWritePost .config/nvim/init.vim source %
	autocmd BufWritePost .config/nvim/config.vim source %
	" Enable ncm2 for all buffers
	"autocmd BufEnter * call ncm2#enable_for_buffer()
augroup END
