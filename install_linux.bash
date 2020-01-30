# WIP: needs to be updated for Arch-linux
sudo pacman -S fish
chsh -s `which fish`

sudo pacman -S ripgrep
sudo pacman -S neovim

pip3 install --user pynvim
git clone https://github.com/VundleVim/Vundle.vim.git ./config/nvim/bundle/Vundle.vim

fish ./linkfiles.fish

nvim +PluginInstall +qall
nvim +UpdateRemotePlugins +qall
cd ./config/nvim/bundle/vimproc.vim
make
cd -

curl -L https://get.oh-my.fish | fish
omf install https://github.com/jhillyerd/plugin-git
omf install bass
omf install pure
ln -s $OMF_PATH/themes/pure/conf.d/pure.fish ~/.config/fish/conf.d/pure.fish
