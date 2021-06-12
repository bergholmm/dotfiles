# dotfiles
Dotfiles for various programs.

## Installation

```bash
git clone https://github.com/bergholmm/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.bash
./fish/install_packages.fish
```

## Linking files

Only link dotfiles (fish shell required)
```bash
cd ~/dotfiles
./linkfiles.fish
```

## Neovim

Only install nvim plugins
```bash
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
```
