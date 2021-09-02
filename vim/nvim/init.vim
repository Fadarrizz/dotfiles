"---------- GENERAL ----------"
set nocompatible
set backspace=indent,eol,start
set history=1000
set ruler
set autoread

" Allow switching buffers without writing to disk
set hidden

set noswapfile
set nobackup
set undofile

set undolevels=10000
set undoreload=10000

" Write automatically when quitting buffer
set autowrite

set nu
set nowrap
set nohlsearch
set incsearch
set scrolloff=8

" Use 4 spaces instead of tab
" Copy indent from current line when starting a new line
set autoindent
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" Indent to 4 spaces, not adding 4
set shiftround

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

" Show signcolumns for linting or github stuff.
set signcolumn=yes

" Don't give |ins-completion-menu| messages.
set shortmess+=c

" Don't display the mode status
set noshowmode

" Better ex autocompletion
set wildmenu
set wildmode=list:longest,full

" Use system clipboard
set clipboard+=unnamedplus

set splitbelow
set splitright

set number
set relativenumber
set autoindent
set shiftwidth=4
set softtabstop=4

"---------- MAPPINGS ----------"
let mapleader = "\<space>"

nmap <Leader>ev :tabedit $MYVIMRC<CR>

" Indent without killing the selection in vmode
vmap < <gv
vmap > >gv

noremap <Leader>h :<C-u>split<CR>
noremap <Leader>v :<C-u>vsplit<CR>

nmap <C-J> <C-W><C-J>
nmap <C-K> <C-W><C-K>
nmap <C-H> <C-W><C-H>
nmap <C-L> <C-W><C-L>

"---------- PATHS ----------"

" Parent paths
let g:dotfiles_path = $HOME . '/.dotfiles'
let g:dotvim_path = $HOME . '/.config/nvim'

" Get path relative to .vim directory
function! DotVimPath(path)
    return g:dotvim_path . '/' . a:path
endfunction

"---------- PLUGINS ----------"

" Source plugins
call plug#begin(stdpath('data') . '/plugged')
    execute 'source' . DotVimPath('after/plugins.vim')
call plug#end()

" Source plugin configs automatically
for file in split(glob(DotVimPath('plugins/*.vim')), '\n')
    execute 'source' file
endfor

if exists("g:did_load_filetypes")
    filetype off
    filetype plugin indent off
endif
filetype off
filetype plugin indent off

lua require("fadarrizz")

"---------- VISUALS ----------"
if (has("termguicolors"))
 set termguicolors
endif

syntax on
colorscheme nord
set background=dark

" Active relativenumber on active buffer
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
augroup END

" Toggle between absolute/relative line numbers
nnoremap <C-n> :let [&nu, &rnu] = [&nu+&rnu==1]<CR>

"---------- AUTO-COMMANDS ----------"
augroup mygroup
	autocmd!
	autocmd BufWritePost ~/config/nvim/init.vim source %
	"autocmd BufWritePost ~/config/nvim/config.vim source %
augroup END
