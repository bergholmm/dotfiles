#!/bin/bash

set -e

echo "Installing brew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

echo "Installing packages"
brew install fish node yarn ripgrep fzf ranger python3 python neovim direnv
brew tap homebrew/cask-versions
brew install --cask iterm2-nightly firefox-developer-edition insomnia slack visual-studio-code
brew tap homebrew/cask-fonts
brew install --cask font-fira-code

echo "Setting up fish"
echo "/usr/local/bin/fish" | sudo tee -a /etc/shells
chsh -s /usr/local/bin/fish

echo "Installing nvm"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash

echo "Linking files"
fish ~/dotfiles/linkfiles.fish

echo "Setting up Neovim"
git clone https://github.com/VundleVim/Vundle.vim.git ~/dotfiles/nvim/bundle/Vundle.vim
pip3 install --user pynvim

nvim +PluginInstall +qall
nvim +UpdateRemotePlugins +qall

cd ~/dotfiles/nvim/bundle/vimproc.vim
make
cd ~/dotfiles/nvim/bundle/coc.nvim
yarn install --frozen-lockfile
cd ~/dotfiles/nvim/bundle/LeaderF
./install.sh

nvim -c 'CocInstall coc-tsserver coc-eslint coc-json coc-prettier coc-css'

# Remove last login when starting new terminal
touch ~/.hushlogin

# Set defaults
./set-defaults.sh

echo "Setting up fish"
echo "run ./install_packages.fish to install fish packages"
curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
