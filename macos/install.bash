#!/bin/bash

set -e

echo "Installing Brew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "Installing basic packages"
brew install fish ripgrep fzf ranger neovim direnv mas python python3 rustup graphviz unzip golang wget

echo "Installing basic apps"
brew tap homebrew/cask-versions
brew install --cask iterm2-nightly firefox-developer-edition insomnia slack visual-studio-code

echo "Installing fonts"
brew tap homebrew/cask-fonts
brew install --cask font-caskaydia-cove-nerd-font

echo "Installing App Store apps"
mas install 441258766 # Magnet

echo "Installing Rust"
rustup-init

echo "Setting up fish"
echo "/usr/local/bin/fish" | sudo tee -a /etc/shells
chsh -s /usr/local/bin/fish

echo "Setting defaults for MacOS"
./set-defaults.sh

# Remove last login when starting new terminal
touch ~/.hushlogin
