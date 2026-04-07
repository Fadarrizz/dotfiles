export EDITOR='nvim'
export DOTFILES=${DOTFILES:="$HOME/.dotfiles"}
export GOPATH=${GOPATH:="$HOME/go"}

typeset -U PATH

export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
export PATH="/opt/homebrew/opt/gnu-tar/libexec/gnubin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.composer/vendor/bin:$PATH"
export PATH="$DOTFILES/bin:$PATH"
export PATH="$GOPATH/bin:$PATH"

export ANDROID_HOME="$HOME/Library/Android/sdk"
export PATH="$PATH:$ANDROID_HOME/platform-tools:$ANDROID_HOME/emulator:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin"

# Set keymap Sessionizer
bindkey -s ^f "t\n"
