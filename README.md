# dotfiles
Dotfiles for neovim, iTerm2, fish, etc.

## Installation

macos
```bash
git clone https://github.com/bergholmm/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install_macos.bash
```

linux (Currently not implemented)
```bash
git clone https://github.com/bergholmm/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install_linux.bash
```

## Extra

Only link dotfiles (fish shell required):
```bash
cd ~/dotfiles
./linkfiles.fish
```

Only install nvim plugins:

```bash
nvim +PluginInstall +qall
```

## TODOs
```
[ ] Setup linux installer 
```
