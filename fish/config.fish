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

set fish_greeting

fish_add_path $HOME/.local/bin
fish_add_path /opt/homebrew/opt/ruby/bin

set -x LDFLAGS -L/opt/homebrew/opt/ruby/lib
set -x CPPFLAGS -I/opt/homebrew/opt/ruby/include

direnv hook fish | source
zoxide init fish | source
starship init fish | source

alias activate_venv='source /Users/marcus.bergholm/Dev/src/.venv/bin/activate.fish; and set -x PYTHONPATH .'

set -gx FZF_DEFAULT_COMMAND 'rg --files --follow --hidden'
set -x LC_ALL en_US.UTF-8
set -x STARSHIP_CONFIG ~/.config/starship.toml


# source $__fish_config_dir/themes/Github\ Dark\ Colorblind.fish
source $__fish_config_dir/themes/gruvbox.fish

# Generated for envman. Do not edit.
test -s "$HOME/.config/envman/load.fish"; and source "$HOME/.config/envman/load.fish"
~/.local/bin/mise activate fish | source
