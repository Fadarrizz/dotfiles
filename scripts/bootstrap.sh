#!/bin/bash

# Dotfiles bootstrapper:
# - installs Homebrew
# - configures XCode, fzf
# based on: https://github.com/sapegin/dotfiles/blob/master/setup/setup.sh

# Exit on any failed command
set -e

# Ask for sudo upfront
sudo -v

# Install Homebrew
if ! command -v brew > /dev/null 2>&1; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"

    brew update
    brew bundle install
    brew cleanup
fi

# Install Oh My Zsh
echo "Installing Oh My Zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Use Touch ID to authorize sudo
if [ ! -f /etc/pam.d/sudo_local ]; then
	echo "Enabling Touch ID to authorize sudo commands..."
	echo "auth       sufficient     pam_tid.so" | sudo tee /etc/pam.d/sudo_local
fi

# Allow unidentified developers
echo "Allowing unidentified developers..."
sudo spctl --master-disable

# Install XCode command line tools, and accept its license
echo "Installing XCode command line tools..."
xcode-select --install
echo
echo "Accepting XCode license..."
xcodebuild -license
echo

# fzf
echo "Configuring fzf..."
$(brew --prefix)/opt/fzf/install
echo

# Create symlink for 1password agent
mkdir -p ~/.1password && ln -s ~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock ~/.1password/agent.sock

# Change the repo remote url to ssh
git remote set-url origin git@github.com:Fadarrizz/dotfiles.git

echo
echo "🦆 All done! Open a new terminal for the changes to take effect."
