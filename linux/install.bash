#!/bin/bash

set -e

echo "Update system"
yay

echo "Install packages"
yay -S fish xsel ripgrep fzf direnv firefox-developer-edition insomnia-bin slack-desktop visual-studio-code-bin graphviz lldb nerd-fonts-complete python-pip tmux archcraft-i3wm

echo "Install rust"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

echo "Install Starship"
sh -c "$(curl -fsSL https://starship.rs/install.sh)"

echo "Install i3 pip package"
pip3 install i3ipc

rm -rf ~/.config/nvim

# Add fish as startup shell: see arch wiki for fish shell

# Cooling:
# https://github.com/liquidctl/liquidctl
