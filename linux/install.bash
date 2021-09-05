#!/bin/bash

set -e

echo "Updating system"
yay

echo "Installing packages"
yay -S fish yarn ripgrep fzf neovim python-neovimc direnv-bin firefox-developer-edition insomnia-bin slack-desktop visual-studio-code-bin ttf-fira-code

echo "Setting fish as default"
chsh -s `which fish`

fish ~/dotfiles/linkfiles.fish

echo "Installing nvm"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash

echo "Setting up neovim"
git clone https://github.com/VundleVim/Vundle.vim.git ~/dotfiles/nvim/bundle/Vundle.vim

nvim +PluginInstall +qall
nvim +UpdateRemotePlugins +qall

cd ~/dotfiles/nvim/bundle/vimproc.vim
make
cd ~/dotfiles/nvim/bundle/coc.nvim
yarn install --frozen-lockfile
cd ~/dotfiles/nvim/bundle/LeaderF
./install.sh

nvim -c 'CocInstall coc-tsserver coc-eslint coc-json coc-prettier coc-css coc-pairs'

echo "Setting up fish"
echo "run ./install_packages.fish to install fish packages"
curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
