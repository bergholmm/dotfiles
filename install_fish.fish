omf install https://github.com/jhillyerd/plugin-git
omf install bass
omf install direnv
omf install pure
ln -s $OMF_PATH/themes/pure/conf.d/pure.fish ~/.config/fish/conf.d/pure.fish
ln -s $OMF_PATH/themes/pure/conf.d/_pure_init.fish ~/.config/fish/conf.d/pure_init.fish
fish ./install_nvm_fish.fish
