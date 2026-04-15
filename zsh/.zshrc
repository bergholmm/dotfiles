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
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source "$ZSH/oh-my-zsh.sh"

# ============================================================================
# Undo OMZ's colorful `ls` aliases (match fish's plain output)
# ============================================================================
unalias ls la ll l 2>/dev/null
unset LSCOLORS LS_COLORS

# ============================================================================
# History
# ============================================================================
HISTSIZE=50000
SAVEHIST=50000
HISTFILE="$HOME/.zsh_history"
setopt SHARE_HISTORY HIST_IGNORE_ALL_DUPS HIST_REDUCE_BLANKS HIST_VERIFY INC_APPEND_HISTORY

# ============================================================================
# Vi keybindings (no mode indicator — starship handles prompt)
# ============================================================================
bindkey -v
export KEYTIMEOUT=1

# Fish-style up-arrow prefix history search
autoload -U up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^[[A' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search
bindkey -M viins '^[[A' up-line-or-beginning-search
bindkey -M viins '^[[B' down-line-or-beginning-search

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
