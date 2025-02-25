_exists() {
  command -v $1 > /dev/null 2>&1
}

alias zshconfig="nvim ~/.zshrc"
alias zshalias="nvim ~/.dotfiles/zsh/custom/aliases.zsh"

# Git
alias nah="git reset --hard && git clean -df"
alias gdlb="git branch --merged | egrep -v '(^\*|master|main)' | xargs git branch -d"

# Dir & listing
#alias l="ls -la"				    # List in long format, include dotfiles
#alias ld="ls -ld */"				    # List in long format, only directories
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# Recursively remove .DS_Store files
alias cleanupds="find . -type f -name '*.DS_Store' -ls -delete"

# Tools
alias cat="bat"

# cd with zsh-z capabilities
# https://github.com/ajeetdsouza/zoxide
if _exists zoxide; then
  alias cd='z'
fi

# Better ls with icons, tree view and more
# https://github.com/eza-community/eza
if _exists eza; then
  alias ls='eza --header --git'
  alias lt='eza --tree'
  alias l='ls -l'
  alias la='ls -lAh'
fi

# Work
alias start="./start.sh"
alias sail='[ -f sail ] && bash sail || bash vendor/bin/sail'
alias s="sail"
alias a="artisan"

# Docs
alias gitalias="curl -s https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/git/README.md"

# Needed for Lazygit in Nvim
alias nvim="nvim --listen /tmp/nvim-server-$(tmux display-message -p '#S').pipe"

if _exists tmux; then
    # alias ts='tmux new-session -A -D -s'
    alias t="tmux-sessionizer"
fi

alias e="edit"
alias d="dot"
alias n="run-watcher"
