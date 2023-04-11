alias zshconfig="nvim ~/.zshrc"
alias zshalias="nvim ~/.dotfiles/zsh/custom/aliases.zsh"

# Git
alias nah="git reset --hard && git clean -df"
alias gdlb="git branch --merged | egrep -v '(^\*|master|main)' | xargs git branch -d"

# Dir & listing
alias l="ls -la"				    # List in long format, include dotfiles
alias ld="ls -ld */"				    # List in long format, only directories
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# Recursively remove .DS_Store files
alias cleanupds="find . -type f -name '*.DS_Store' -ls -delete"

# Tools
alias lzd="lazydocker"
alias cat="bat"
#alias db='() { open mysql://127.0.0.1/$1; }'
alias ts='tmux new-session -A -D -s'

# Work
alias start="./start.sh"
alias sail='[ -f sail ] && bash sail || bash vendor/bin/sail'
alias s="sail"

# Docs
alias gitalias="curl -s https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/git/README.md"
