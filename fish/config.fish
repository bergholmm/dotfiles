function vi_key_bindings
    fish_vi_key_bindings
end

# Hide vim mode indicator
function fish_mode_prompt
    # NOOP - Disable vim mode indicator
end

set -g fish_key_bindings vi_key_bindings

set -gx EDITOR nvim
alias n nvim

set fish_greeting

fish_add_path $HOME/.local/bin
fish_add_path /opt/homebrew/opt/ruby/bin
fish_add_path /opt/homebrew/bin
fish_add_path /opt/homebrew/opt/openjdk@17/bin

set -x LDFLAGS -L/opt/homebrew/opt/ruby/lib
set -x CPPFLAGS -I/opt/homebrew/opt/ruby/include

zoxide init fish | source
starship init fish | source

set -gx FZF_DEFAULT_COMMAND 'rg --files --follow --hidden'
fzf --fish | source
set -x LC_ALL en_US.UTF-8
set -x STARSHIP_CONFIG ~/.config/starship.toml

# Generated for envman. Do not edit.
test -s "$HOME/.config/envman/load.fish"; and source "$HOME/.config/envman/load.fish"
~/.local/bin/mise activate fish | source

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
