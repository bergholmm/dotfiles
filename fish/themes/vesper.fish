# ~/.config/fish/conf.d/vesper.fish
# ---------------------------------------------------------------------------
#  Vesper – peppermint & orange
# ---------------------------------------------------------------------------
#  Ported from datsfilipe/vesper.nvim (fg ≈ #cccccc, bg = #101010)
#  Accent colours
#    peppermint → #99FFE4   |   orange → #FFCFA8
#    red        → #FF8080   |   yellow → #FFC799
#    grey       → #65737E   |   dark   → #343434
# ---------------------------------------------------------------------------

# --- core ------------------------------------------------------------------
set -g fish_color_normal '#cccccc' # plain text
set -g fish_color_command '#99ffe4' # external commands
set -g fish_color_keyword '#ffcfa8' # if, else, for, function…
set -g fish_color_param '#ffffff' # arguments / variables
set -g fish_color_quote '#ffc799' # single & double quotes
set -g fish_color_redirection '#ff8080' # > >> |
set -g fish_color_end '#65737e' # argument separators ; &
set -g fish_color_error --bold '#ff8080' # syntax errors

# --- UI helpers ------------------------------------------------------------
set -g fish_color_comment '#505050' # `# comments`
set -g fish_color_operator '#ffcfa8'
set -g fish_color_escape '#99ffe4' # \n \x1b etc.
set -g fish_color_cancel --reverse '#ff8080'

# matches / selections / pager
set -g fish_color_search_match --background='#343434'
set -g fish_color_selection --background='#232323'
set -g fish_color_match '#ffcfa8' --background='#232323'

# autosuggestions & completions
set -g fish_color_autosuggestion '#505050'
set -g fish_color_history_current '#ffcfa8'
set -g fish_pager_color_progress '#505050'
set -g fish_pager_color_prefix '#99ffe4'
set -g fish_pager_color_completion '#cccccc'
set -g fish_pager_color_description '#505050'

# prompt helper colours (cwd, host, user)
set -g fish_color_cwd '#ffcfa8'
set -g fish_color_cwd_root --bold '#ff8080'
set -g fish_color_host '#99ffe4'
set -g fish_color_host_remote --bold '#99ffe4'
set -g fish_color_user '#ffcfa8'

# ---------------------------------------------------------------------------
#   reload with:   source ~/.config/fish/conf.d/vesper.fish
# ---------------------------------------------------------------------------
