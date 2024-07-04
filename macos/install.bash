#!/bin/bash

set -e

echo "Installing Brew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "Installing basic packages"
brew install fish ripgrep fzf ranger neovim direnv mas python python3 rustup graphviz unzip golang wget fnm duf bat git-delta fd gnu-sed lazygit colima docker docker-Buildx coreutils curl k9s kubectx bash

echo "Installing basic apps"
brew install --cask insomnia slack visual-studio-code notion kitty notion-calendar obsidian font-iosevka-term-nerd-font font-iosevka-nerd-font font-iosevka

echo "Installing App Store apps"
# mas install 441258766 # Magnet

# Remove last login when starting new terminal
touch ~/.hushlogin
