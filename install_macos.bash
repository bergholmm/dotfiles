#!/bin/bash

set -e

echo "Installing brew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

echo "Setting up fish"
brew install fish
echo "/usr/local/bin/fish" | sudo tee -a /etc/shells
chsh -s /usr/local/bin/fish

echo "Installing packages"
brew install nvm node yarn ripgrep fzf ranger python3 python neovim direnv
brew tap homebrew/cask-versions
brew cask install iterm2-nightly firefox-developer-edition insomnia slack visual-studio-code spotify spotify-tui
brew tap homebrew/cask-fonts
brew cask install font-fira-code

echo "Linking files"
fish ./linkfiles.fish

echo "Setting up Neovim"
git clone https://github.com/VundleVim/Vundle.vim.git ./config/nvim/bundle/Vundle.vim
pip3 install --user pynvim

nvim +PluginInstall +qall
nvim +UpdateRemotePlugins +qall

cd ./config/nvim/bundle/vimproc.vim
make
cd -
cd ./config/nvim/bundle/coc.nvim
yarn install --frozen-lockfile
cd -
cd ./config/nvim/bundle/LeaderF
./install.sh
cd -

nvim -c 'CocInstall coc-tsserver coc-eslint coc-json coc-prettier coc-css'

# Remove last login when starting new terminal
touch ~/.hushlogin

echo "Setting up fish"
echo "run ./install_fish.fish to install fish packages"
curl -L https://get.oh-my.fish | fish
