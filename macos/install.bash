#!/bin/bash

set -e

echo "Installing Brew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "Installing basic packages"
brew install fish ripgrep fzf ranger neovim direnv mas python python3 rustup graphviz unzip golang wget fnm duf bat git-delta fd gnu-sed

echo "Installing basic apps"
brew tap homebrew/cask-versions
brew install --cask iterm2-nightly firefox-developer-edition insomnia slack visual-studio-code notion kitty

echo "Installing fonts"
brew tap homebrew/cask-fonts
brew install --cask font-caskaydia-cove-nerd-font
brew install --cask font-iosevka-term-nerd-font
brew install --cask font-iosevka-nerd-font

brew install jesseduffield/lazygit/lazygit
brew install lazygit

echo "Installing App Store apps"
# mas install 441258766 # Magnet

echo "Setting up fish"
echo "/usr/local/bin/fish" | sudo tee -a /etc/shells
chsh -s /usr/local/bin/fish

echo "Installing Rust"
rustup-init

echo "Installing Node"
fnm install 16.16.0
fnm default 16.16.0

echo "Setting defaults for MacOS"
./set-defaults.sh

# Remove last login when starting new terminal
touch ~/.hushlogin
