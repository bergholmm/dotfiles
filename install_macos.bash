#!/bin/bash

echo "Installing command line tools"
xcode-select --install

echo "Installing brew"
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "Setting up fish"
brew install fish
echo "/usr/local/bin/fish" | sudo tee -a /etc/shells
chsh -s /usr/local/bin/fish

echo "Installing packages"
brew tap caskroom/versions
brew cask install iterm2-nightly
brew install yarn
brew install ripgrep
brew install fzf
brew install ranger
brew install python
brew install python2
brew install neovim
brew cask install brave

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
./install.sh nightly
cd -

nvim +CocInstall coc-tsserver coc-eslint coc-json coc-prettier coc-css +qall

echo "Setting up fish"
curl -L https://get.oh-my.fish | fish
omf install https://github.com/jhillyerd/plugin-git
omf install bass
omf install pure
ln -s $OMF_PATH/themes/pure/conf.d/pure.fish ~/.config/fish/conf.d/pure.fish
ln -s $OMF_PATH/themes/pure/conf.d/_pure_init.fish ~/.config/fish/conf.d/pure_init.fish

echo "Setup iTerm2 tab-bar/tabs: https://www.felixjung.io/posts/pretty-iterm2-with-a-modern-titlebar/"

# Remove last login when starting new terminal
touch ~/.hushlogin
