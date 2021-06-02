" Themes
Plug 'gruvbox-community/gruvbox'

" General
Plug 'itchyny/lightline.vim' " status bar
Plug 'tpope/vim-abolish' " easily search, substitue, abbreviate multiple abbreviate multiple version of words, coercion to camel case / snake case / dote case / title case
Plug 'tpope/vim-commentary' " Comment stuff ou
Plug 'mbbill/undotree' " Switch between undo branches

" (Terminal) Navigation
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'ThePrimeagen/harpoon'

" Working with tags
Plug 'tpope/vim-surround' " surround text objects with parenthesis, quotes, html tags
Plug 'alvan/vim-closetag'

" fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install()} } 	"Get latest binary.
Plug 'junegunn/fzf.vim'

" Compiler
Plug 'neomake/neomake'

" Linter
Plug 'dense-analysis/ale'

" PHP
Plug 'StanAngeloff/php.vim', {'for': 'php'}
Plug 'stephpy/vim-php-cs-fixer', {'for': 'php'}
Plug 'nishigori/vim-php-dictionary', {'for': 'php'}
Plug 'phpactor/phpactor', {'for': 'php', 'do': 'composer install --no-dev -o'}
Plug '2072/php-indenting-for-vim', {'for': 'php'}
Plug 'arnaud-lb/vim-php-namespace', {'for': 'php'}
Plug 'lvht/phpcd.vim', { 'for': 'php', 'do': 'composer install' }

" Python
Plug 'vim-syntastic/syntastic'
Plug 'nvie/vim-flake8'

" Autocompletion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Git
Plug 'airblade/vim-gitgutters'
Plug 'tpope/vim-fugitive'

" JS
Plug 'pangloss/vim-javascript'
Plug 'posva/vim-vue/'
