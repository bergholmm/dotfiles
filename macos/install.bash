#!/bin/bash

set -e

echo "Installing Brew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "Installing basic packages"
brew install fish ripgrep fzf ranger neovim direnv mas python python3 rustup graphviz

# add lldb to linux install

echo "Installing basic apps"
brew tap homebrew/cask-versions
brew install --cask iterm2-nightly firefox-developer-edition insomnia slack visual-studio-code

echo "Installing fonts"
brew tap homebrew/cask-fonts
brew install --cask font-caskaydia-cove-nerd-font

echo "Installing App Store apps"
mas install 441258766

echo "Setting up fish and linking dotfiles"
echo "/usr/local/bin/fish" | sudo tee -a /etc/shells
chsh -s /usr/local/bin/fish
fish $PWD/linkfiles.fish

echo "Setting defaults for MacOS"
./set-defaults.sh

echo "Installing Rust"
rustup-init

# Remove last login when starting new terminal
touch ~/.hushlogin


#-------------------------------------------

# Move to fish shell from now on...

curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
fisher install edc/bass pure-fish/pure jhillyerd/plugin-git dracula/fish

echo "Installing NVM, Yarn, Node"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
nvm install node
brew install yarn
