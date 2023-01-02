" Themes
" Plug 'gruvbox-community/gruvbox'
Plug 'arcticicestudio/nord-vim'

" General
Plug 'itchyny/lightline.vim' " status bar
Plug 'tpope/vim-abolish' " easily search, substitue, abbreviate multiple abbreviate multiple version of words, coercion to camel case / snake case / dote case / title case
Plug 'tpope/vim-commentary' " Comment stuff ou
Plug 'tpope/vim-repeat'
Plug 'mbbill/undotree' " Switch between undo branches
Plug 'terryma/vim-smooth-scroll'
Plug 'tpope/vim-projectionist'

" Navigation
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" (Terminal) Navigation
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'ThePrimeagen/harpoon'
Plug 'voldikss/vim-floaterm'

" Working with tags
Plug 'tpope/vim-surround' " surround text objects with parenthesis, quotes, html tags
Plug 'alvan/vim-closetag'

" fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install()} } 	"Get latest binary.
Plug 'junegunn/fzf.vim'

Plug 'sheerun/vim-polyglot'

Plug 'neovim/nvim-lspconfig'

" PHP
Plug 'phpactor/phpactor', {'for': 'php', 'do': 'composer install --no-dev -o'}
Plug '2072/php-indenting-for-vim', {'for': 'php'}
Plug 'arnaud-lb/vim-php-namespace', {'for': 'php'}
Plug 'lvht/phpcd.vim', { 'for': 'php', 'do': 'composer install' }
Plug 'vim-test/vim-test'

" Python
Plug 'vim-syntastic/syntastic'
Plug 'nvie/vim-flake8'

" Autocompletion
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'antoinemadec/coc-fzf'

" Git
Plug 'tpope/vim-fugitive'

" JS
Plug 'pangloss/vim-javascript'
Plug 'posva/vim-vue/'
