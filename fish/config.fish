function vi_key_bindings
    fish_vi_key_bindings
    bind -M insert -m default jj force-repaint
    bind -M visual -m default jj force-repaint
end

# Hide vim mode indicator
function fish_mode_prompt
    # NOOP - Disable vim mode indicator
end

set -g fish_key_bindings vi_key_bindings

set -gx EDITOR nvim
alias n nvim
# alias nvim lvim

set fish_greeting

set -gx ENCORE_INSTALL "/home/bergholmm/.encore"
set -gx PNPM_HOME /Users/bergholm/Library/pnpm

fish_add_path $PNPM_HOME
fish_add_path $ENCORE_INSTALL/bin
fish_add_path $HOME/.nix-profile/bin
fish_add_path $HOME/.local/bin
fish_add_path $HOME/.cargo/bin


direnv hook fish | source
zoxide init fish | source
starship init fish | source

set -gx FZF_DEFAULT_COMMAND 'rg --files --follow --hidden'
set -x LC_ALL en_US.UTF-8

source $__fish_config_dir/themes/Github\ Dark\ Colorblind.fish

function nvm
    bass source ~/.nvm/nvm.sh --no-use ';' nvm $argv
end

# Generated for envman. Do not edit.
test -s "$HOME/.config/envman/load.fish"; and source "$HOME/.config/envman/load.fish"

# Google Cloud SDK
source "$(brew --prefix)/share/google-cloud-sdk/path.fish.inc"

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
