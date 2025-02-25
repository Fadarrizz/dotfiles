# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Locale
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

# If you come from bash you might have to change your $PATH.
# export PATH="/usr/local/sbin:$PATH"

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Enable completions
autoload -Uz compinit && compinit

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM=$DOTFILES/zsh/custom

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export NVM_DIR="$HOME/.nvm"
source $DOTFILES/zsh/themes/powerlevel10k/powerlevel10k.zsh-theme

# Source config
# source $DOTFILES/zsh/custom/aliases.zsh
# source $DOTFILES/zsh/custom/functions.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f $DOTFILES/zsh/custom/.p10k.zsh ]] || source $DOTFILES/zsh/custom/.p10k.zsh

# Like cd but with z-zsh capabilities
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

# Fuzzy finder bindings
if [ -f "$HOME/.fzf.zsh" ]; then
  source "$HOME/.fzf.zsh"
fi

if [ -d "$HOME/myenv" ]; then
    source "$HOME/myenv/bin/activate"
fi

# export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Completion for 1password
eval "$(op completion zsh)"; compdef _op op

# Completion for Klog
source <(klog completion -c zsh)
