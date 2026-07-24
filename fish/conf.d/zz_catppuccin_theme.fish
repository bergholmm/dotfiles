function __dotfiles_apply_catppuccin_theme --argument-names mode
    switch $mode
        case light
            set -g fish_color_normal 4c4f69
            set -g fish_color_command 1e66f5
            set -g fish_color_param dd7878
            set -g fish_color_keyword d20f39
            set -g fish_color_quote 40a02b
            set -g fish_color_redirection ea76cb
            set -g fish_color_end fe640b
            set -g fish_color_comment 8c8fa1
            set -g fish_color_error d20f39
            set -g fish_color_gray 9ca0b0
            set -g fish_color_selection --background=ccd0da
            set -g fish_color_search_match --background=ccd0da
            set -g fish_color_operator ea76cb
            set -g fish_color_escape e64553
            set -g fish_color_autosuggestion 9ca0b0
            set -g fish_color_cancel d20f39
            set -g fish_color_cwd df8e1d
            set -g fish_color_user 179299
            set -g fish_color_host 1e66f5
            set -g fish_color_host_remote 40a02b
            set -g fish_color_status d20f39
            set -g fish_pager_color_progress 9ca0b0
            set -g fish_pager_color_prefix ea76cb
            set -g fish_pager_color_completion 4c4f69
            set -g fish_pager_color_description 9ca0b0
        case '*'
            set -g fish_color_normal cdd6f4
            set -g fish_color_command 89b4fa
            set -g fish_color_param f2cdcd
            set -g fish_color_keyword f38ba8
            set -g fish_color_quote a6e3a1
            set -g fish_color_redirection f5c2e7
            set -g fish_color_end fab387
            set -g fish_color_comment 7f849c
            set -g fish_color_error f38ba8
            set -g fish_color_gray 6c7086
            set -g fish_color_selection --background=313244
            set -g fish_color_search_match --background=313244
            set -g fish_color_operator f5c2e7
            set -g fish_color_escape eba0ac
            set -g fish_color_autosuggestion 6c7086
            set -g fish_color_cancel f38ba8
            set -g fish_color_cwd f9e2af
            set -g fish_color_user 94e2d5
            set -g fish_color_host 89b4fa
            set -g fish_color_host_remote a6e3a1
            set -g fish_color_status f38ba8
            set -g fish_pager_color_progress 6c7086
            set -g fish_pager_color_prefix f5c2e7
            set -g fish_pager_color_completion cdd6f4
            set -g fish_pager_color_description 6c7086
    end
end

function __dotfiles_on_catppuccin_mode --on-variable __dotfiles_catppuccin_mode
    __dotfiles_apply_catppuccin_theme $__dotfiles_catppuccin_mode
end

if not set -q __dotfiles_catppuccin_mode
    set -U __dotfiles_catppuccin_mode dark
end

__dotfiles_apply_catppuccin_theme $__dotfiles_catppuccin_mode
