#!/bin/bash

set -e

echo "Installing command line tools"
xcode-select --install

echo "Installing brew"
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "Setting up fish"
brew install fish
echo "/usr/local/bin/fish" | sudo tee -a /etc/shells
chsh -s /usr/local/bin/fish

echo "Installing packages"
brew install nvm node yarn ripgrep fzf ranger python python2 neovim direnv
brew tap caskroom/versions
brew cask install iterm2-nightly brave google-chrome firefox insomnia slack visual-studio-code spotify docker
brew tap heroku/brew
brew install heroku
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

nvim +CocInstall coc-tsserver coc-eslint coc-json coc-prettier coc-css +qall

echo "Setting up fish"
curl -L https://get.oh-my.fish | fish
omf install https://github.com/jhillyerd/plugin-git
omf install bass
omf install direnv
omf install pure
ln -s $OMF_PATH/themes/pure/conf.d/pure.fish ~/.config/fish/conf.d/pure.fish
ln -s $OMF_PATH/themes/pure/conf.d/_pure_init.fish ~/.config/fish/conf.d/pure_init.fish
fish ./install_nvm_fish.fish

echo "Setup iTerm2 tab-bar/tabs: https://www.felixjung.io/posts/pretty-iterm2-with-a-modern-titlebar/"

# Remove last login when starting new terminal
touch ~/.hushlogin
