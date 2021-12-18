export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

export JAVA_HOME=$(/usr/libexec/java_home -v 15)
export ANDROID_HOME=$HOME/Library/Android/sdk/
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

export PATH=$PATH:~/Documents/nand2tetris/tools
export PATH=$PATH:$HOME/.dotfiles/scripts
