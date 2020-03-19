filetype off

call plug#begin('~/nvim/plugged')

" Themes
"Plug 'nightsense/carbonized'
"Plug 'rakr/vim-one'
Plug 'mhartington/oceanic-next'
"Plug 'vim-airline/vim-airline-themes'
"Plug 'flazz/vim-colorschemes'

" Support bundles
"Plug 'moll/vim-bbye'
"Plug 'vim-scripts/gitignore'

" Git
Plug 'tpope/vim-fugitive'																									" :G to call any Git command.
"Plug 'int3/vim-extradite'
"Plug 'airblade/vim-gitgutter'

" File navigation
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'tpope/vim-vinegar'
"Plug 'ryanoasis/vim-devicons'
"Plug 'vim-airline/vim-airline'
"Plug 'junegunn/fzf', { 'do': './install --bin' } 	"Get latest binary.
"Plug 'junegunn/fzf.vim'

" Text manipulation
"Plug 'bfredl/nvim-miniyank'
"Plug 'preservim/nerdcommenter'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'

" Autocomplete
"Plug 'ncm2/ncm2'
"Plug 'roxma/nvim-yarp'
" NOTE: you need to install completion sources to get completions. Check
" our wiki page for a list of sources: https://github.com/ncm2/ncm2/wiki
"Plug 'ncm2/ncm2-bufword'
"Plug 'ncm2/ncm2-path'
    
" HTML, CSS, JS, PHP, JSON, etc.
"Plug 'StanAngeloff/php.vim'
"Plug 'stephpy/vim-php-cs-fixer'
"Plug 'phpactor/phpactor'
"Plug 'ncm2/ncm2-tern'
"Plug 'phpactor/ncm2-phpactor'
"Plug 'elzr/vim-json'
"Plug 'hail2u/vim-css3-syntax', { 'for': ['vim-plug', 'php', 'html', 'javascript', 'css', 'scss'] }

" IMPORTANT :help Ncm2PopupOpen for more information
"set completeopt=noinsert,menuone,noselect

" Initialize plugin system
call plug#end()

filetype plugin indent on
