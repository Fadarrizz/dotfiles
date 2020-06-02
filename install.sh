#!/bin/sh

echo "Setting up your Mac..."

# Check for Homebrew and install if we don't have it
if test ! $(which brew); then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

# Update Homebrew recipes
brew update

# Install all our dependencies with bundle (See Brewfile)
brew tap homebrew/bundle
brew bundle

# Install Oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install global Composer packages
/usr/local/bin/composer global require laravel/installer

# Create a Sites directory
# This is a default directory for macOS user accounts but doesn't comes pre-installed
mkdir $HOME/Sites

# Removes .zshrc from $HOME (if it exists) and symlinks the .zshrc file from the .dotfiles
rm -rf $HOME/.zshrc
ln -s $HOME/.dotfiles/.zshrc $HOME/.zshrc

# Symlink the Mackup config file to the home directory
ln -s $HOME/.dotfiles/Backup/Mackup/.mackup.cfg $HOME/.mackup.cfg

# Symlink Neovim config
mkdir $HOME/.config/nvim
ln -s $HOME/.dotfiles/.config/nvim/init.vim $HOME/.config/nvim/init.vim
ln -s $HOME/.dotfiles/.config/nvim/plugins.vim $HOME/.config/nvim/plugins.vim

# Set macOS preferences
# We will run this last because this will reload the shell
source .macos
