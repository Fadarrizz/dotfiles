# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export DOTFILES=$HOME/.dotfiles/zsh
export ZSH=$HOME/.oh-my-zsh

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

#export PATH="/usr/local/sbin:$PATH"
export PATH=$PATH:~/Documents/nand2tetris/tools
export PATH=$PATH:$ANDROID_HOME/platform-tools
export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)
export ANDROID_HOME=$HOME/.android
export ANDROID_SDK_ROOT=/usr/local/share/android-sdk

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f $DOTFILES/custom/.p10k.zsh ]] || source $DOTFILES/custom/.p10k.zsh
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/opt/node@10/bin:$PATH"

source $ZSH/oh-my-zsh.sh
source $DOTFILES/custom/aliases.zsh
source $DOTFILES/custom/functions.zsh
source $DOTFILES/themes/powerlevel10k/powerlevel10k.zsh-theme

if [ -f /Users/fadarrizz/.tnsrc ]; then 
    source /Users/fadarrizz/.tnsrc 
fi

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

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

ZSH_CUSTOM=$DOTFILES/custom

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  brew
  docker
  git
  iterm2
  vi-mode
  zsh-autosuggestions
)
