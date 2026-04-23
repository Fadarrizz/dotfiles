# Locale
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

# History
HISTSIZE=10000
HISTFILESIZE=10000
HIST_STAMPS="yyyy-mm-dd"
HISTFILE=~/.zsh_history
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY

# Completions
autoload -Uz compinit && compinit

# Custom aliases/functions
source "$DOTFILES/zsh/custom/aliases.zsh"
source "$DOTFILES/zsh/custom/functions.zsh"

# Plugins (managed through Homebrew)
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh  # must be last among plugins

# Tools
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

export SDKMAN_DIR=$(brew --prefix sdkman-cli)/libexec
[[ -s "${SDKMAN_DIR}/bin/sdkman-init.sh" ]] && source "${SDKMAN_DIR}/bin/sdkman-init.sh"

# Like cd but better
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

# Python virtualenv
if [ -d "$HOME/myenv" ]; then
  source "$HOME/myenv/bin/activate"
fi

# Ruby env
eval "$(rbenv init - --no-rehash zsh)"

# Klog completions
source <(klog completion -c zsh)

# Set keymap Sessionizer
bindkey -s ^f "t\n"

# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/aukegeerts/.docker/completions $fpath)
autoload -Uz compinit
compinit
# End of Docker CLI completions

# Prompt (must be last)
eval "$(starship init zsh)"
