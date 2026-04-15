# ============================================================================
# Environment
# ============================================================================
export EDITOR="nvim"
export LC_ALL="en_US.UTF-8"

# ============================================================================
# PATH
# ============================================================================
typeset -U path PATH
path=(
  "$HOME/.local/bin"
  "/opt/homebrew/opt/ruby/bin"
  "/opt/homebrew/bin"
  "/opt/homebrew/opt/openjdk@17/bin"
  "$HOME/Library/Android/sdk/platform-tools"
  "$HOME/.bun/bin"
  "$HOME/.koda/bin"
  $path
)

export ANDROID_HOME="$HOME/Library/Android/sdk"
export BUN_INSTALL="$HOME/.bun"
export LDFLAGS="-L/opt/homebrew/opt/ruby/lib"
export CPPFLAGS="-I/opt/homebrew/opt/ruby/include"
export STARSHIP_CONFIG="$HOME/.config/starship.toml"
export FZF_DEFAULT_COMMAND='rg --files --follow --hidden'

# ============================================================================
# oh-my-zsh
# ============================================================================
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""                # Prompt handled by starship
DISABLE_AUTO_UPDATE="true"  # Let brew/git manage updates
plugins=(git)

source "$ZSH/oh-my-zsh.sh"

# ============================================================================
# Vi keybindings (no mode indicator — starship handles prompt)
# ============================================================================
bindkey -v
export KEYTIMEOUT=1

# ============================================================================
# Custom functions (autoloaded from dotfiles/zsh/functions/)
# ============================================================================
fpath=("$HOME/.config/zsh/functions" $fpath)
autoload -Uz gbage gtest ggtr

# ============================================================================
# Aliases
# ============================================================================
source "$HOME/.config/zsh/aliases.zsh"

# ============================================================================
# Tool inits
# ============================================================================
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
source <(fzf --zsh)
eval "$("$HOME/.local/bin/mise" activate zsh)"

# envman
[[ -s "$HOME/.config/envman/load.zsh" ]] && source "$HOME/.config/envman/load.zsh"
