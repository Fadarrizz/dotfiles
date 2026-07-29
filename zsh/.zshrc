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

# Set keymap Sessionizer
bindkey -s ^f "t\n"

# Prompt (must be last)
eval "$(starship init zsh)"
