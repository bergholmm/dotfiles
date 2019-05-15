# Load vi_mode
function vi_key_bindings
    fish_vi_key_bindings
    bind -M insert -m default jj force-repaint
    bind -M visual -m default jj force-repaint
end

set -g fish_key_bindings vi_key_bindings

# Use neovim as editor
alias vim nvim
set -gx EDITOR nvim

# Android path
set -gx ANDROID_HOME /usr/local/share/android-sdk

# Setpu direnv
eval (direnv hook fish)

# Aliases for encryption
alias encrypt 'openssl enc -aes-256-cbc -a'
alias decrypt 'openssl enc -aes-256-cbc -a -d'

# Hide vim mode indicator
function fish_mode_prompt
  # NOOP - Disable vim mode indicator
end

set -gx FZF_DEFAULT_COMMAND  'rg --files --follow --hidden'
