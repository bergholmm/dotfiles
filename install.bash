if test "$(uname)" = "Darwin"
then
  ./macos/install.bash
else
  ./linux/install.bash
fi

echo "Linking dotfiles"
fish $PWD/linkfiles.fish

echo "Installing NVM, Yarn, Node"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
nvm install node

echo "Installing npm packages"
npm i -g yarn eslint prettier neovim

echo "Installing pip packages"
pip install pynvim

echo "Installing fisher and fish plugins"
fish curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
fish fisher install edc/bass jhillyerd/plugin-git dracula/fish

exit 0
