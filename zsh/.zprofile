typeset -U PATH

export PATH="/bin:$PATH"
export PATH="/sbin:$PATH"
export PATH="/usr/bin:$PATH"
export PATH="/usr/sbin:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
export PATH="/opt/homebrew/opt/gnu-tar/libexec/gnubin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.composer/vendor/bin:$PATH"
export PATH="$DOTFILES/bin:$PATH"
export PATH="$GOPATH/bin:$PATH"
export PATH="$PATH:$ANDROID_HOME/platform-tools:$ANDROID_HOME/emulator:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin"

# git-ai PATH (added by MDM post-install)
export PATH="/Users/auke.geerts/.git-ai/bin/:$PATH"
