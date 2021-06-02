
" Declare group for autocmd for whole vimrc, and clear it
" Otherwise every autocmd will be added to group each time vimrc is sourced
augroup vimrc
    autocmd!
augroup END

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
call plug#begin('~/.vim/plugged')
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

" Coc extensions
let g:coc_global_extensions = [
    \ 'coc-snippets',
    \ 'coc-pairs',
    \ 'coc-json',
    \ 'coc-css',
    \ 'coc-html',
    \ 'coc-yaml',
    \]

"---------- VISUALS ----------"
if (has("termguicolors"))
 set termguicolors
endif

syntax on
colorscheme gruvbox
set background=dark

set number
set autoindent
set shiftwidth=4
set softtabstop=4

set number relativenumber

" Active relativenumber on active buffer
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
augroup END

" Toggle between absolute/relative line numbers
nnoremap <C-n> :let [&nu, &rnu] = [&nu+&rnu==1]<CR>

"---------- FINDING FILES ----------"
nmap <Leader>o :Files<CR>
nmap <leader>e :Buffers<CR>
nmap <leader>g :GFiles<CR>
nmap <leader>h :History<CR>

" --column: Show column number
" --line-number: Show line number
" --no-heading: Do not show file headings in results
" --fixed-strings: Search term as a literal string
" --ignore-case: Case insensitive search
" --no-ignore: Do not respect .gitignore, etc...
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
" --color: Search color options
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)

" Map above defined Find command
nmap <leader>f :Find<CR>

"---------- NETRW ----------"
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_winsize = 20

function! OpenToRight()
  :normal v
  let g:path=expand('%:p')
  :q!
  execute 'belowright vnew' g:path
  :normal <C-w>l
endfunction

function! OpenBelow()
  :normal v
  let g:path=expand('%:p')
  :q!
  execute 'belowright new' g:path
  :normal <C-w>l
endfunction

function! NetrwMappings()
  " Hack fix to make ctrl-l work properly
  noremap <buffer> <A-l> <C-w>l
  noremap <buffer> <C-l> <C-w>l
  noremap <silent> <leader>n :call ToggleNetrw()<CR>
  noremap <buffer> V :call OpenToRight()<cr>
  noremap <buffer> H :call OpenBelow()<cr>
endfunction

augroup netrw_mappings
  autocmd!
  autocmd filetype netrw call NetrwMappings()
augroup END

" Allow for netrw to be toggled
function! ToggleNetrw()
  if g:NetrwIsOpen
      let i = bufnr("$")
      while (i >= 1)
	  if (getbufvar(i, "&filetype") == "netrw")
	      silent exe "bwipeout " . i
	  endif
	  let i-=1
      endwhile
      let g:NetrwIsOpen=0
  else
      let g:NetrwIsOpen=1
      silent Lexplore
  endif
endfunction

" Check before opening buffer on any file
function! NetrwOnBufferOpen()
  if exists('b:noNetrw')
    return
  endif
  call ToggleNetrw()
endfun

" Close Netrw if it's the only buffer open
autocmd WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&filetype") == "netrw" || &buftype == 'quickfix' |q|endif

" Make netrw act like a project Draw
augroup ProjectDrawer
    autocmd VimEnter * :call NetrwOnBufferOpen()
augroup END

let g:NetrwIsOpen=0

"---------- SEARCH ----------"
:let @/ = ""

"---------- ALE ----------"

" disable linting while typing
"let g:ale_lint_on_text_changed = 'never'
"let g:ale_lint_on_enter = 0
"let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
"let g:ale_open_list = 1
"let g:ale_keep_list_window_open=0
"let g:ale_set_quickfix=0
"let g:ale_list_window_size = 5
"let g:ale_php_phpcbf_standard='PSR2'
"let g:ale_php_phpcs_standard='phpcs.xml.dist'
"let g:ale_php_phpmd_ruleset='phpmd.xml'
"let g:ale_fixers = {
"  \ '*': ['remove_trailing_lines', 'trim_whitespace'],
"  \ 'php': ['phpcbf', 'php_cs_fixer', 'remove_trailing_lines', 'trim_whitespace'],
"  \}
"let g:ale_fix_on_save = 1
let g:ale_linters = {
\   'php': ['php'],
\}
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0

"---------- AUTOCOMPLETION ----------"
" parameter expansion for selected entry via Enter
"inoremap <silent> <expr> <CR> (pumvisible() ? ncm2_ultisnips#expand_or("\<CR>", 'n') : "\<CR>")

" cycle through completion entries with tab/shift+tab
"inoremap <expr> <TAB> pumvisible() ? "\<c-n>" : "\<TAB>"
"inoremap <expr> <s-tab> pumvisible() ? "\<c-p>" : "\<TAB>"

"---------- TABS ----------"
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"

" PHP7
let g:ultisnips_php_scalar_types = 1

"---------- TABS ----------"
set splitbelow
set splitright

nmap <C-J> <C-W><C-J>
nmap <C-K> <C-W><C-K>
nmap <C-H> <C-W><C-H>
nmap <C-L> <C-W><C-L>

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
set undodir=~/.vim/undodir

set undolevels=10000
set undoreload=10000

let mapleader=" "
let maplocalleader=" "

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

" Fast saves
nnoremap <leader>w :w!<CR>
set updatetime=300

" Write and quit all
nnoremap <leader>wq :wqa!<CR>

" Quit all
nnoremap <leader>q :qa!<CR>

" Close current buffer
nnoremap <leader>bd :bd<CR>

" Use system clipboard
set clipboard+=unnamedplus

" Indent without killing the selection in vmode
vmap < <gv
vmap > >gv

" Buffer cleanup - delete every buffer except the open one
command! Ball :silent call general#Bdeleteonly()

" Fold related
set foldmethod=indent
set foldlevelstart=99 
nnoremap <Enter> za

"---------- SPLITS ----------"
noremap <Leader>h :<C-u>split<CR>
noremap <Leader>v :<C-u>vsplit<CR>

"---------- MAPPINGS ----------"
"Edit Vimrc file.
nmap <Leader>ev :tabedit $MYVIMRC<CR>

"---------- AUTO-COMMANDS ----------"
augroup mygroup
	autocmd!
	autocmd BufWritePost ~/config/nvim/init.vim source %
	"autocmd BufWritePost ~/config/nvim/config.vim source %
augroup END
