function vi_key_bindings
    fish_vi_key_bindings
    bind -M insert -m default jj force-repaint
    bind -M visual -m default jj force-repaint
end

set -g fish_key_bindings vi_key_bindings

set -gx EDITOR lvim
set fish_greeting

set PATH $HOME/.cargo/bin $PATH
set PATH $HOME/.local/bin $PATH

# Hide vim mode indicator
function fish_mode_prompt
  # NOOP - Disable vim mode indicator
end

set -gx FZF_DEFAULT_COMMAND  'rg --files --follow --hidden'
set -x LC_ALL en_US.UTF-8

# Use "r" as command for ranger with the addition that is changes
# the current directory for fish when exited
function r
    set tmpfile "/tmp/pwd-from-ranger"
    ranger --choosedir=$tmpfile $argv
    set rangerpwd (cat $tmpfile)
    if test "$PWD" != $rangerpwd
        cd $rangerpwd
    end
end

function nvm
    bass source ~/.nvm/nvm.sh --no-use ';' nvm $argv
end

# Generated for envman. Do not edit.
test -s "$HOME/.config/envman/load.fish"; and source "$HOME/.config/envman/load.fish"

alias n lvim
alias nvim lvim
# alias t tmux

direnv hook fish | source
zoxide init fish | source
starship init fish | source
