filetype off

call plug#begin('~/nvim/plugged')

" Themes
Plug 'gruvbox-community/gruvbox'

" Support bundles
"Plug 'moll/vim-bbye'
"Plug 'vim-scripts/gitignore'

" Git

" File navigation
"Plug 'tpope/vim-vinegar'
Plug 'vim-airline/vim-airline'
Plug 'junegunn/fzf', { 'do': './install --bin' } 	"Get latest binary.
Plug 'junegunn/fzf.vim'

" Text manipulation

" Snippets
Plug 'SirVer/ultisnips' | Plug 'phux/vim-snippets'

" Autocompletion
"Plug 'ncm2/ncm2'
"Plug 'roxma/nvim-yarp'
"Plug 'roxma/vim-hug-neovim-rpc'

"Plug 'phpactor/phpactor', {'do': ':call phpactor#Update()', 'for': 'php'}
"Plug 'phpactor/ncm2-phpactor', {'for': 'php'}
"Plug 'ncm2/ncm2-ultisnips'

" Linter
Plug 'dense-analysis/ale'

" HTML, CSS, JS, PHP, JSON, etc.
Plug 'StanAngeloff/php.vim'
"Plug 'shawncplus/phpcomplete.vim'
"Plug 'stephpy/vim-php-cs-fixer'
"Plug 'phpactor/phpactor'
"Plug 'ncm2/ncm2-tern'
"Plug 'elzr/vim-json'
"Plug 'hail2u/vim-css3-syntax', { 'for': ['vim-plug', 'php', 'html', 'javascript', 'css', 'scss'] }

" Initialize plugin system
call plug#end()

filetype plugin indent on
