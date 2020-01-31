echo "Installing fish"
yay -S fish
chsh -s `which fish`

echo "Installing packages"
yay -S ripgrep fzf neovim yarn npm nvm brave ranger

echo "Linking files"
fish ./linkfiles.fish

echo "Setting up neovim"
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
