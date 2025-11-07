#!/bin/bash

set -e

echo "Installing Brew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "Installing basic packages"
brew install fish ripgrep fzf ranger neovim direnv python python3 rustup graphviz unzip golang wget duf bat git-delta fd gnu-sed lazygit colima docker docker-Buildx coreutils curl k9s kubectx bash pnpm pyvim

echo "Installing basic apps"
brew install --cask slack cursor notion kitty obsidian font-iosevka-term-nerd-font font-iosevka-nerd-font font-iosevka unnaturalscrollwheels arc raycast eurkey nordvpn

# Remove last login when starting new terminal
touch ~/.hushlogin
