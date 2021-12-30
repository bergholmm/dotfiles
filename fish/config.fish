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

# Aliases for encryption
alias encrypt 'openssl enc -aes-256-cbc -a'
alias decrypt 'openssl enc -aes-256-cbc -a -d'

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

nvm use default --silent

set PATH $HOME/.cargo/bin $PATH
set PATH $HOME/.local/bin $PATH
set PATH $HOME/go/bin $PATH

# Setup direnv
direnv hook fish | source


# Embark colorscheme for fish shell
# set fish_color_autosuggestion FFE6B3
# set fish_color_command A1EFD3
# set fish_color_comment 585273
# set fish_color_cwd FFE6B3
# set fish_color_end D4BFFF
# set fish_color_error F02E6E
# set fish_color_escape F2B482
# set fish_color_keyword F48FB1
# set fish_color_match $fish_color_cwd
# set fish_color_normal CBE3E7
# set fish_color_operator --bold $fish_color_cwd
# set fish_color_param $fish_color_normal
# set fish_color_quote 87DFEB
# set fish_color_redirection F48FB1
# set fish_color_search_match --background=3E3859
# set fish_color_selection $fish_color_comment
#
# set fish_color_cancel 3E3859
# set fish_color_host 63F2F1
# set fish_color_host_remote $fish_color_quote
# set fish_color_user 62D196
#
# set fish_pager_color_progress --background=63F2F1 1E1C31
# set fish_pager_color_description $fish_color_command
# set fish_pager_color_selected_description --underline $fish_color_command
