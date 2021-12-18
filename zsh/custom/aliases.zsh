alias zshconfig="nvim ~/.zshrc"
alias zshalias="nvim ~/.dotfiles/zsh/custom/aliases.zsh"

# Git
alias gs="git status"
alias gl="gi log"
alias gcom="git checkout master"
alias gaa="git add ."
alias gc="git commit -m "
alias gp="git push"
alias nah="git reset --hard && git clean -df"
alias gundo="git reset HEAD~1 --mixed"
alias gco="git checkout"
alias gcob="git checkout -b"
alias gdlb="git branch --merged | egrep -v '(^\*|master|main)' | xargs git branch -d"
alias glog="git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"

# Dir & listing
alias l="ls -la"				    # List in long format, include dotfiles
alias ld="ls -ld */"				    # List in long format, only directories
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
#alias mkcd='() { mkdir -p "$@" && cd "$@"; }'

# Recursively remove .DS_Store files
alias cleanupds="find . -type f -name '*.DS_Store' -ls -delete"

# Tools
alias lzd="lazydocker"
alias cat="bat"
#alias db='() { open mysql://127.0.0.1/$1; }'
