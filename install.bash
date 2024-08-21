if test "$(uname)" = "Darwin"; then
  ./macos/install.bash
else
  ./linux/install.bash
fi

echo "Linking dotfiles"
fish $PWD/linkfiles.fish

echo "Setting fish theme"
# fish_config theme save Nord

echo "Installing npm packages"
npm i -g yarn eslint prettier neovim

echo "Install linters"
rustup-init
cargo install stylua
go install mvdan.cc/gofumpt@latest

echo "Installing pip packages"
pip install pynvim

echo "Installing fisher and fish plugins"
curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
fisher install edc/bass jhillyerd/plugin-git

echo "Installing utils"
curl -sS https://webinstall.dev/zoxide | bash
curl https://mise.run | sh
curl -sS https://starship.rs/install.sh | sh

exit 0
