# Environment
export EDITOR="nvim"
alias n="nvim"

# PATH setup
typeset -U path PATH
path=("$HOME/.local/bin" "/opt/homebrew/opt/ruby/bin" "/opt/homebrew/bin" $path)

export LDFLAGS="-L/opt/homebrew/opt/ruby/lib"
export CPPFLAGS="-I/opt/homebrew/opt/ruby/include"

# Tools
eval "$(direnv hook zsh)"
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

export FZF_DEFAULT_COMMAND='rg --files --follow --hidden'
export LC_ALL="en_US.UTF-8"
export STARSHIP_CONFIG="$HOME/.config/starship.toml"

# Generated for envman. Do not edit.
if [ -s "$HOME/.config/envman/load.zsh" ]; then
  source "$HOME/.config/envman/load.zsh"
fi

eval "$("$HOME/.local/bin/mise" activate zsh)"

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

# Launch fish
if [[ -o interactive && -o login && $SHLVL -eq 1 ]]; then
  parent_cmd=$(ps -p $PPID -o comm=)
  if [[ $parent_cmd != fish ]] && command -v fish >/dev/null 2>&1; then
    exec fish --login
  fi
fi

