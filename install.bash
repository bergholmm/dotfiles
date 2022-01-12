if test "$(uname)" = "Darwin"
then
  ./macos/install.bash
else
  ./linux/install.bash
fi

echo "Linking dotfiles"
fish $PWD/linkfiles.fish

echo "Install Nvchad and custom Neovim setup"
git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1
ln $PWD/nvim/lua/custom ~/.config/nvim/lua/custom

echo "Installing Rust"
rustup-init

echo "Installing fisher and fish plugins"
fish curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
fish fisher install edc/bass pure-fish/pure jhillyerd/plugin-git dracula/fish

echo "Installing NVM, Yarn, Node"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
nvm install node

if test "$(uname)" = "Darwin"
then
  brew install yarn
else
  echo "install yarn linux"
fi

echo "Installing Eslint and Prettier"
yarn global add eslint prettier

exit 0
