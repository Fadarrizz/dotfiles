export EDITOR='nvim'
export DOTFILES=${DOTFILES:="$HOME/.dotfiles"}
export GOPATH=${GOPATH:="$HOME/go"}
export ANDROID_HOME="$HOME/Library/Android/sdk"
export SSH_AUTH_SOCK="$HOME/.ssh/proton-pass-agent.sock"
export JAVA_HOME="$(/usr/libexec/java_home -v 21)"

[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
