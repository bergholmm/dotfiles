set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config

for i in conf.d functions completions
  curl https://git.io/$i.nvm.fish --create-dirs -sLo $XDG_CONFIG_HOME/fish/$i/nvm.fish
end
