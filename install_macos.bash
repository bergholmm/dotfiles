#!/bin/bash

echo "Installing command line tools"
xcode-select --install

echo "Installing brew"
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "Setting up fish"
brew install fish
echo "/usr/local/bin/fish" | sudo tee -a /etc/shells
chsh -s /usr/local/bin/fish

echo "Installing iTerm2"
brew tap caskroom/versions
brew cask install iterm2-nightly

echo "Installing yarn"
brew install yarn

echo "Installing fonts"
brew tap homebrew/cask-fonts
brew cask install font-hack-nerd-font

echo "Installing ripgrep + fzf"
brew install ripgrep
brew install fzf

echo "Setting up Neovim"
brew install python
brew install python2
brew install neovim
git clone https://github.com/VundleVim/Vundle.vim.git ./config/nvim/bundle/Vundle.vim

fish ./linkfiles.fish

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

echo "Installing Google chrome"
brew cask install google-chrome

# Remove last login when starting new terminal
touch ~/.hushlogin

echo "Setup yabai and skhd"
# brew tap koekeishiya/formulae
# brew install skhd
# brew install yabai
# sudo yabai --install-sa
# brew services start skhd
# brew services start yabai

echo "Setting up omf"
curl -L https://get.oh-my.fish | fish
omf install direnv
omf install https://github.com/jhillyerd/plugin-git
omf install bass
omf install pure
ln -s $OMF_PATH/themes/pure/conf.d/pure.fish ~/.config/fish/conf.d/pure.fish

echo "Setup iTerm2 tab-bar/tabs: https://www.felixjung.io/posts/pretty-iterm2-with-a-modern-titlebar/"
# echo "Setup SIP https://koekeishiya.github.io/chunkwm/docs/sa.html"
