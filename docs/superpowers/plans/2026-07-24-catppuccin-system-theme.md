# Catppuccin System Theme Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Make Kitty, Ghostty, Neovim, fish, zsh, and tmux follow macOS light/dark appearance live using Catppuccin Latte and Mocha.

**Architecture:** Use native theme switching in Kitty and Ghostty, Neovim plugin-based switching, and a small `dark-notify`-triggered macOS sync script for fish, zsh, and tmux. Keep generated runtime state under `~/.local/state/dotfiles-theme` and keep checked-in source files focused on static config and reusable palette snippets.

**Tech Stack:** Bash, fish, zsh, tmux, LazyVim/lazy.nvim, kitty 0.45.0, Ghostty 1.3.1, Homebrew `cormacrelf/tap/dark-notify`, macOS LaunchAgent.

## Global Constraints

- Light mode is Catppuccin Latte.
- Dark mode is Catppuccin Mocha.
- Accent is Catppuccin mauve.
- Live switching is required when macOS appearance changes.
- Include Kitty, Ghostty, Neovim, fish, zsh, tmux, and macOS install/link support.
- Exclude WezTerm.
- Exclude Linux-only desktop components such as Waybar, mako, wlogout, and sway.
- zsh switching may occur on the next prompt because fish is the active login shell.
- `dark-notify` must be installed from `cormacrelf/tap`.
- Preserve unrelated user changes, including the existing unstaged `nvim/lazyvim.json` change.

---

## File Structure

- Create `macos/sync_theme.bash`: detects macOS appearance, updates runtime theme state, applies fish universal mode, writes zsh generated theme, and reloads tmux.
- Create `macos/test_theme_sync.bash`: lightweight verification harness for script syntax, mode override behavior, LaunchAgent template validity, and generated state.
- Create `macos/launchagents/com.marcus.dotfiles.theme-sync.plist.template`: LaunchAgent template filled by `macos/install.bash`.
- Modify `macos/install.bash`: tap/install `dark-notify`, render the LaunchAgent, bootstrap it, and run the sync script once.
- Create `fish/conf.d/zz_catppuccin_theme.fish`: applies Catppuccin fish colors at startup and whenever the watcher changes the universal mode variable.
- Create `zsh/theme.zsh`: sources generated zsh theme state on startup and on the next prompt when the generated file changes.
- Modify `zsh/.zshrc`: source `~/.config/zsh/theme.zsh` after zsh-syntax-highlighting setup.
- Modify `linkfiles.fish`: symlink `zsh/theme.zsh` into `~/.config/zsh`.
- Create `tmux/themes/catppuccin-latte.conf` and `tmux/themes/catppuccin-mocha.conf`: status/pane/message colors.
- Modify `tmux/tmux.conf`: source current runtime tmux theme state when present and keep keybindings/plugins unchanged.
- Create `kitty/light-theme.auto.conf`, `kitty/dark-theme.auto.conf`, and `kitty/no-preference-theme.auto.conf`: generated from kitty's Catppuccin themes.
- Modify `kitty/kitty.conf`: stop including static `current-theme.conf` so auto theme files own the palette.
- Modify `ghostty/config`: use Ghostty's built-in Catppuccin light/dark theme pair.
- Modify `nvim/lua/plugins/core.lua`: replace active Cursor Dark config with Catppuccin and `auto-dark-mode.nvim`.
- Modify `nvim/lua/plugins/lualine.lua`: remove hard-coded Cursor Dark/Catppuccin Mocha background from lualine config.
- Modify `nvim/lua/config/autocmds.lua`: remove Mocha-only bufferline highlight overrides.

---

### Task 1: Add Theme Sync Script And Test Harness

**Files:**
- Create: `macos/sync_theme.bash`
- Create: `macos/test_theme_sync.bash`

**Interfaces:**
- Produces: executable `macos/sync_theme.bash` with optional `--mode light|dark`, `--dry-run`, and `--skip-reload` flags.
- Produces: generated runtime files under `${XDG_STATE_HOME:-$HOME/.local/state}/dotfiles-theme`.
- Consumed by: LaunchAgent in Task 5, fish/zsh/tmux configs in Task 2, verification in Task 6.

- [ ] **Step 1: Write the failing verification harness**

Create `macos/test_theme_sync.bash`:

```bash
#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
state_dir="$(mktemp -d)"
trap 'rm -rf "$state_dir"' EXIT

cd "$repo_dir"

echo "Checking script syntax"
bash -n macos/sync_theme.bash

echo "Checking dry-run light mode"
XDG_STATE_HOME="$state_dir" macos/sync_theme.bash --mode light --dry-run --skip-reload | grep -q "mode=light"

echo "Checking dry-run dark mode"
XDG_STATE_HOME="$state_dir" macos/sync_theme.bash --mode dark --dry-run --skip-reload | grep -q "mode=dark"

echo "Checking generated light state"
XDG_STATE_HOME="$state_dir" macos/sync_theme.bash --mode light --skip-reload
grep -q "DOTFILES_CATPPUCCIN_MODE=light" "$state_dir/dotfiles-theme/zsh-theme.zsh"
test -L "$state_dir/dotfiles-theme/tmux-theme.conf"
readlink "$state_dir/dotfiles-theme/tmux-theme.conf" | grep -q "catppuccin-latte.conf"

echo "Checking generated dark state"
XDG_STATE_HOME="$state_dir" macos/sync_theme.bash --mode dark --skip-reload
grep -q "DOTFILES_CATPPUCCIN_MODE=dark" "$state_dir/dotfiles-theme/zsh-theme.zsh"
readlink "$state_dir/dotfiles-theme/tmux-theme.conf" | grep -q "catppuccin-mocha.conf"

echo "theme sync checks passed"
```

- [ ] **Step 2: Run the harness to verify it fails**

Run:

```bash
bash macos/test_theme_sync.bash
```

Expected: FAIL with `macos/sync_theme.bash: No such file or directory`.

- [ ] **Step 3: Add the sync script implementation**

Create `macos/sync_theme.bash`:

```bash
#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
STATE_DIR="$STATE_HOME/dotfiles-theme"
MODE=""
DRY_RUN=0
SKIP_RELOAD=0

usage() {
  printf 'Usage: %s [--mode light|dark] [--dry-run] [--skip-reload]\n' "$0" >&2
}

while (($#)); do
  case "$1" in
    --mode)
      MODE="${2:-}"
      shift 2
      ;;
    --dry-run)
      DRY_RUN=1
      shift
      ;;
    --skip-reload)
      SKIP_RELOAD=1
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      usage
      exit 2
      ;;
  esac
done

if [[ -n "$MODE" && "$MODE" != "light" && "$MODE" != "dark" ]]; then
  printf 'Invalid mode: %s\n' "$MODE" >&2
  exit 2
fi

detect_mode() {
  if [[ -n "$MODE" ]]; then
    printf '%s\n' "$MODE"
    return
  fi

  local dark_mode
  if dark_mode="$(osascript -e 'tell application "System Events" to tell appearance preferences to get dark mode' 2>/dev/null)"; then
    if [[ "$dark_mode" == "true" ]]; then
      printf 'dark\n'
    else
      printf 'light\n'
    fi
    return
  fi

  printf 'dark\n'
}

write_zsh_theme() {
  local mode="$1"
  local target="$STATE_DIR/zsh-theme.zsh"

  if [[ "$mode" == "light" ]]; then
    cat > "$target" <<'ZSH'
export DOTFILES_CATPPUCCIN_MODE=light
typeset -gA ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[command]='fg=#1e66f5'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=#1e66f5'
ZSH_HIGHLIGHT_STYLES[function]='fg=#1e66f5'
ZSH_HIGHLIGHT_STYLES[alias]='fg=#1e66f5'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=#1e66f5,underline'
ZSH_HIGHLIGHT_STYLES[hashed-command]='fg=#1e66f5'
ZSH_HIGHLIGHT_STYLES[comment]='fg=#8c8fa1'
ZSH_HIGHLIGHT_STYLES[path]='fg=#4c4f69,underline'
ZSH_HIGHLIGHT_STYLES[globbing]='fg=#8839ef'
ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=#8839ef'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=#8839ef'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=#8839ef'
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#9ca0b0'
ZSH
  else
    cat > "$target" <<'ZSH'
export DOTFILES_CATPPUCCIN_MODE=dark
typeset -gA ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[command]='fg=#89b4fa'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=#89b4fa'
ZSH_HIGHLIGHT_STYLES[function]='fg=#89b4fa'
ZSH_HIGHLIGHT_STYLES[alias]='fg=#89b4fa'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=#89b4fa,underline'
ZSH_HIGHLIGHT_STYLES[hashed-command]='fg=#89b4fa'
ZSH_HIGHLIGHT_STYLES[comment]='fg=#7f849c'
ZSH_HIGHLIGHT_STYLES[path]='fg=#cdd6f4,underline'
ZSH_HIGHLIGHT_STYLES[globbing]='fg=#cba6f7'
ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=#cba6f7'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=#cba6f7'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=#cba6f7'
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#6c7086'
ZSH
  fi
}

apply_fish_mode() {
  local mode="$1"

  if ! command -v fish >/dev/null 2>&1; then
    return
  fi

  if [[ "$DRY_RUN" -eq 1 ]]; then
    return
  fi

  fish -c "set -U __dotfiles_catppuccin_mode $mode" >/dev/null 2>&1 || true
}

apply_tmux_mode() {
  local mode="$1"
  local theme

  if [[ "$mode" == "light" ]]; then
    theme="$DOTFILES_DIR/tmux/themes/catppuccin-latte.conf"
  else
    theme="$DOTFILES_DIR/tmux/themes/catppuccin-mocha.conf"
  fi

  ln -sfn "$theme" "$STATE_DIR/tmux-theme.conf"

  if [[ "$DRY_RUN" -eq 1 || "$SKIP_RELOAD" -eq 1 ]]; then
    return
  fi

  if command -v tmux >/dev/null 2>&1 && tmux info >/dev/null 2>&1; then
    tmux source-file "$theme" >/dev/null 2>&1 || true
  fi
}

main() {
  local mode
  mode="$(detect_mode)"
  mkdir -p "$STATE_DIR"
  printf '%s\n' "$mode" > "$STATE_DIR/mode"
  write_zsh_theme "$mode"
  apply_tmux_mode "$mode"
  apply_fish_mode "$mode"
  printf 'mode=%s\n' "$mode"
}

main "$@"
```

- [ ] **Step 4: Make both scripts executable**

Run:

```bash
chmod +x macos/sync_theme.bash macos/test_theme_sync.bash
```

Expected: no output.

- [ ] **Step 5: Run the harness and capture the next expected failure**

Run:

```bash
bash macos/test_theme_sync.bash
```

Expected: FAIL because `tmux/themes/catppuccin-latte.conf` and `tmux/themes/catppuccin-mocha.conf` do not exist yet.

- [ ] **Step 6: Commit Task 1**

Run:

```bash
git add macos/sync_theme.bash macos/test_theme_sync.bash
git commit -m "feat: add macos theme sync script"
```

Expected: commit succeeds.

---

### Task 2: Add fish, zsh, and tmux Theme Consumers

**Files:**
- Create: `fish/conf.d/zz_catppuccin_theme.fish`
- Create: `zsh/theme.zsh`
- Modify: `zsh/.zshrc`
- Modify: `linkfiles.fish`
- Create: `tmux/themes/catppuccin-latte.conf`
- Create: `tmux/themes/catppuccin-mocha.conf`
- Modify: `tmux/tmux.conf`
- Test: `macos/test_theme_sync.bash`

**Interfaces:**
- Consumes: `__dotfiles_catppuccin_mode` fish universal variable from Task 1.
- Consumes: `~/.local/state/dotfiles-theme/zsh-theme.zsh` from Task 1.
- Consumes: `~/.local/state/dotfiles-theme/tmux-theme.conf` symlink from Task 1.
- Produces: shell/tmux live or next-prompt theme application.

- [ ] **Step 1: Add fish theme consumer**

Create `fish/conf.d/zz_catppuccin_theme.fish`:

```fish
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
```

- [ ] **Step 2: Add zsh generated-theme consumer**

Create `zsh/theme.zsh`:

```zsh
# Catppuccin theme state generated by macos/sync_theme.bash.

typeset -g __DOTFILES_THEME_FILE="${XDG_STATE_HOME:-$HOME/.local/state}/dotfiles-theme/zsh-theme.zsh"
typeset -g __DOTFILES_THEME_MTIME=""

__dotfiles_theme_mtime() {
  stat -f "%m" "$__DOTFILES_THEME_FILE" 2>/dev/null || stat -c "%Y" "$__DOTFILES_THEME_FILE" 2>/dev/null
}

__dotfiles_source_theme() {
  [[ -r "$__DOTFILES_THEME_FILE" ]] || return

  local mtime
  mtime="$(__dotfiles_theme_mtime)" || return

  if [[ "$mtime" != "$__DOTFILES_THEME_MTIME" ]]; then
    source "$__DOTFILES_THEME_FILE"
    __DOTFILES_THEME_MTIME="$mtime"
  fi
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd __dotfiles_source_theme
__dotfiles_source_theme
```

- [ ] **Step 3: Source the zsh theme consumer**

In `zsh/.zshrc`, after the existing zsh highlight style block and before `History`, add:

```zsh
# ============================================================================
# Catppuccin theme sync
# ============================================================================
[[ -s "$HOME/.config/zsh/theme.zsh" ]] && source "$HOME/.config/zsh/theme.zsh"
```

Expected location: after the current `ZSH_HIGHLIGHT_STYLES[hashed-command]='fg=blue'` line.

- [ ] **Step 4: Link zsh theme consumer**

In `linkfiles.fish`, after the `aliases.zsh` symlink block, add:

```fish
echo "Creating symlink: ~/.config/zsh/theme.zsh -> $dir/zsh/theme.zsh"
ln -sf $dir/zsh/theme.zsh ~/.config/zsh/theme.zsh
```

- [ ] **Step 5: Add tmux Catppuccin Latte theme**

Create `tmux/themes/catppuccin-latte.conf`:

```tmux
set -g status-style "bg=#eff1f5,fg=#4c4f69"
set -g message-style "bg=#ccd0da,fg=#4c4f69"
set -g message-command-style "bg=#ccd0da,fg=#4c4f69"
set -g pane-border-style "fg=#ccd0da"
set -g pane-active-border-style "fg=#8839ef"

set -g @tmux-dotbar-bg "#eff1f5"
set -g @tmux-dotbar-fg "#9ca0b0"
set -g @tmux-dotbar-fg-current "#4c4f69"
set -g @tmux-dotbar-fg-session "#9ca0b0"
set -g @tmux-dotbar-fg-prefix "#8839ef"
```

- [ ] **Step 6: Add tmux Catppuccin Mocha theme**

Create `tmux/themes/catppuccin-mocha.conf`:

```tmux
set -g status-style "bg=#1e1e2e,fg=#cdd6f4"
set -g message-style "bg=#313244,fg=#cdd6f4"
set -g message-command-style "bg=#313244,fg=#cdd6f4"
set -g pane-border-style "fg=#313244"
set -g pane-active-border-style "fg=#cba6f7"

set -g @tmux-dotbar-bg "#1e1e2e"
set -g @tmux-dotbar-fg "#6c7086"
set -g @tmux-dotbar-fg-current "#cdd6f4"
set -g @tmux-dotbar-fg-session "#6c7086"
set -g @tmux-dotbar-fg-prefix "#cba6f7"
```

- [ ] **Step 7: Source current tmux runtime theme**

In `tmux/tmux.conf`, replace the current hard-coded `@tmux-dotbar-*` color lines with this fallback block:

```tmux
set -g @tmux-dotbar-bg "#1e1e2e"
set -g @tmux-dotbar-fg "#6c7086"
set -g @tmux-dotbar-fg-current "#cdd6f4"
set -g @tmux-dotbar-fg-session "#6c7086"
set -g @tmux-dotbar-fg-prefix "#cba6f7"

if-shell 'test -r "${XDG_STATE_HOME:-$HOME/.local/state}/dotfiles-theme/tmux-theme.conf"' 'source-file "${XDG_STATE_HOME:-$HOME/.local/state}/dotfiles-theme/tmux-theme.conf"'
```

- [ ] **Step 8: Run shell/tmux syntax checks**

Run:

```bash
fish -n fish/conf.d/zz_catppuccin_theme.fish
zsh -n zsh/theme.zsh
zsh -n zsh/.zshrc
tmux -f /dev/null source-file tmux/themes/catppuccin-latte.conf
tmux -f /dev/null source-file tmux/themes/catppuccin-mocha.conf
bash macos/test_theme_sync.bash
```

Expected: all commands exit 0 and `theme sync checks passed` is printed.

- [ ] **Step 9: Commit Task 2**

Run:

```bash
git add fish/conf.d/zz_catppuccin_theme.fish zsh/theme.zsh zsh/.zshrc linkfiles.fish tmux/themes/catppuccin-latte.conf tmux/themes/catppuccin-mocha.conf tmux/tmux.conf macos/test_theme_sync.bash
git commit -m "feat: sync shell and tmux catppuccin themes"
```

Expected: commit succeeds.

---

### Task 3: Configure Kitty And Ghostty Native Auto Themes

**Files:**
- Create: `kitty/light-theme.auto.conf`
- Create: `kitty/dark-theme.auto.conf`
- Create: `kitty/no-preference-theme.auto.conf`
- Modify: `kitty/kitty.conf`
- Modify: `ghostty/config`

**Interfaces:**
- Kitty consumes `*.auto.conf` files directly from `~/.config/kitty`.
- Ghostty consumes built-in theme names `Catppuccin Latte` and `Catppuccin Mocha`.

- [ ] **Step 1: Generate Kitty auto theme files**

Run:

```bash
/Applications/kitty.app/Contents/MacOS/kitty +kitten themes --dump-theme Catppuccin-Latte > kitty/light-theme.auto.conf
/Applications/kitty.app/Contents/MacOS/kitty +kitten themes --dump-theme Catppuccin-Mocha > kitty/dark-theme.auto.conf
cp kitty/light-theme.auto.conf kitty/no-preference-theme.auto.conf
```

Expected: files are created and contain `background              #EFF1F5` for light and `background              #1E1E2E` for dark.

- [ ] **Step 2: Stop including the old static Kitty theme**

In `kitty/kitty.conf`, replace the final line:

```conf
include current-theme.conf
```

with:

```conf
# Catppuccin light/dark auto theme files live beside this config:
# light-theme.auto.conf, dark-theme.auto.conf, no-preference-theme.auto.conf
```

- [ ] **Step 3: Configure Ghostty native split theme**

In `ghostty/config`, replace:

```conf
theme = cursor-dark
```

with:

```conf
theme = light:Catppuccin Latte,dark:Catppuccin Mocha
```

- [ ] **Step 4: Verify terminal theme configs**

Run:

```bash
grep -q '#EFF1F5' kitty/light-theme.auto.conf
grep -q '#1E1E2E' kitty/dark-theme.auto.conf
/Applications/Ghostty.app/Contents/MacOS/ghostty +list-themes | grep -q 'Catppuccin Latte'
/Applications/Ghostty.app/Contents/MacOS/ghostty +list-themes | grep -q 'Catppuccin Mocha'
```

Expected: all commands exit 0.

- [ ] **Step 5: Commit Task 3**

Run:

```bash
git add kitty/light-theme.auto.conf kitty/dark-theme.auto.conf kitty/no-preference-theme.auto.conf kitty/kitty.conf ghostty/config
git commit -m "feat: use catppuccin auto themes in terminals"
```

Expected: commit succeeds.

---

### Task 4: Configure Neovim Catppuccin Live Switching

**Files:**
- Modify: `nvim/lua/plugins/core.lua`
- Modify: `nvim/lua/plugins/lualine.lua`
- Modify: `nvim/lua/config/autocmds.lua`

**Interfaces:**
- Produces: LazyVim colorscheme provider using `catppuccin/nvim`.
- Produces: live light/dark switching using `f-person/auto-dark-mode.nvim`.
- Consumes: macOS appearance through the Neovim plugin.

- [ ] **Step 1: Replace Cursor Dark with Catppuccin and auto-dark-mode**

In `nvim/lua/plugins/core.lua`, replace the first two plugin specs:

```lua
  {
    "bergholmm/cursor-dark.nvim",
    priority = 1000,
    lazy = false,
    config = function()
      vim.opt.termguicolors = true
      vim.cmd.colorscheme("cursor-dark")
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "cursor-dark",
    },
  },
```

with:

```lua
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    lazy = false,
    opts = {
      flavour = "mocha",
      background = {
        light = "latte",
        dark = "mocha",
      },
      integrations = {
        blink_cmp = true,
        bufferline = true,
        gitsigns = true,
        lsp_trouble = true,
        native_lsp = {
          enabled = true,
        },
        noice = true,
        notify = true,
        treesitter = true,
        which_key = true,
      },
    },
    config = function(_, opts)
      vim.opt.termguicolors = true
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme(vim.o.background == "light" and "catppuccin-latte" or "catppuccin-mocha")
    end,
  },
  {
    "f-person/auto-dark-mode.nvim",
    lazy = false,
    opts = {
      update_interval = 1000,
      fallback = "dark",
      set_dark_mode = function()
        vim.o.background = "dark"
        vim.cmd.colorscheme("catppuccin-mocha")
      end,
      set_light_mode = function()
        vim.o.background = "light"
        vim.cmd.colorscheme("catppuccin-latte")
      end,
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-mocha",
    },
  },
```

- [ ] **Step 2: Remove hard-coded lualine background**

In `nvim/lua/plugins/lualine.lua`, replace:

```lua
      local auto_theme_custom = require("lualine.themes.auto")
      auto_theme_custom.normal.c.bg = "#181818"
```

with:

```lua
      local auto_theme_custom = require("lualine.themes.auto")
```

Keep the rest of the lualine config unchanged.

- [ ] **Step 3: Remove Mocha-only BufferLine overrides**

In `nvim/lua/config/autocmds.lua`, delete the entire `vim.cmd([[ ... ]])` block named `MyColors` at the top of the file. Keep the `QuitPre` autocmd.

The file should start with:

```lua
-- Quit all windows when explorer is open (so :q exits Neovim)
vim.api.nvim_create_autocmd("QuitPre", {
```

- [ ] **Step 4: Verify Neovim starts and uses Catppuccin**

Run:

```bash
nvim --headless '+lua print(vim.g.colors_name or "none")' +qa 2>&1 | grep -E 'catppuccin-(latte|mocha)'
```

Expected: command exits 0 and prints either `catppuccin-latte` or `catppuccin-mocha`.

- [ ] **Step 5: Commit Task 4**

Run:

```bash
git add nvim/lua/plugins/core.lua nvim/lua/plugins/lualine.lua nvim/lua/config/autocmds.lua nvim/lazy-lock.json
git commit -m "feat: switch neovim to catppuccin system theme"
```

Expected: commit succeeds. If `nvim/lazy-lock.json` changes because lazy.nvim resolves `auto-dark-mode.nvim`, include that lockfile. Do not stage `nvim/lazyvim.json` unless it is intentionally changed by this task.

---

### Task 5: Add macOS LaunchAgent And Install Support

**Files:**
- Create: `macos/launchagents/com.marcus.dotfiles.theme-sync.plist.template`
- Modify: `macos/install.bash`
- Test: `macos/test_theme_sync.bash`

**Interfaces:**
- Consumes: `macos/sync_theme.bash` from Task 1.
- Consumes: Homebrew `dark-notify`.
- Produces: `~/Library/LaunchAgents/com.marcus.dotfiles.theme-sync.plist`.

- [ ] **Step 1: Add LaunchAgent template**

Create `macos/launchagents/com.marcus.dotfiles.theme-sync.plist.template`:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "https://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>Label</key>
  <string>com.marcus.dotfiles.theme-sync</string>

  <key>ProgramArguments</key>
  <array>
    <string>__HOMEBREW_PREFIX__/bin/dark-notify</string>
    <string>-c</string>
    <string>__DOTFILES_DIR__/macos/sync_theme.bash</string>
  </array>

  <key>RunAtLoad</key>
  <true/>

  <key>KeepAlive</key>
  <true/>

  <key>StandardOutPath</key>
  <string>__HOME__/Library/Logs/dotfiles-theme-sync.log</string>

  <key>StandardErrorPath</key>
  <string>__HOME__/Library/Logs/dotfiles-theme-sync.err.log</string>
</dict>
</plist>
```

- [ ] **Step 2: Extend the test harness for plist rendering**

Append this block to `macos/test_theme_sync.bash` before the final `echo "theme sync checks passed"` line:

```bash
echo "Checking LaunchAgent template"
test -f macos/launchagents/com.marcus.dotfiles.theme-sync.plist.template
rendered_plist="$state_dir/com.marcus.dotfiles.theme-sync.plist"
sed \
  -e "s#__DOTFILES_DIR__#$repo_dir#g" \
  -e "s#__HOMEBREW_PREFIX__#/opt/homebrew#g" \
  -e "s#__HOME__#$HOME#g" \
  macos/launchagents/com.marcus.dotfiles.theme-sync.plist.template > "$rendered_plist"
plutil -lint "$rendered_plist" >/dev/null
```

- [ ] **Step 3: Run the harness to verify it fails before install changes**

Run:

```bash
bash macos/test_theme_sync.bash
```

Expected: FAIL until the LaunchAgent template exists, then PASS after Step 1 and Step 2 are both complete.

- [ ] **Step 4: Update macOS install script**

In `macos/install.bash`, after `set -e`, add:

```bash
script_dir="$(cd "$(dirname "$0")" && pwd)"
repo_dir="$(cd "$script_dir/.." && pwd)"
```

Replace the existing basic package install command:

```bash
brew install fish ripgrep fzf ranger neovim direnv python python3 rustup graphviz unzip golang wget duf bat git-delta fd gnu-sed lazygit colima docker docker-Buildx coreutils curl k9s kubectx bash pnpm pyvim
```

with:

```bash
brew tap cormacrelf/tap
brew install fish ripgrep fzf ranger neovim direnv python python3 rustup graphviz unzip golang wget duf bat git-delta fd gnu-sed lazygit colima docker docker-Buildx coreutils curl k9s kubectx bash pnpm pyvim cormacrelf/tap/dark-notify
```

Before `touch ~/.hushlogin`, add:

```bash
echo "Installing theme sync LaunchAgent"
homebrew_prefix="$(brew --prefix)"
launch_agent_dir="$HOME/Library/LaunchAgents"
launch_agent="$launch_agent_dir/com.marcus.dotfiles.theme-sync.plist"
mkdir -p "$launch_agent_dir" "$HOME/Library/Logs"
sed \
  -e "s#__DOTFILES_DIR__#$repo_dir#g" \
  -e "s#__HOMEBREW_PREFIX__#$homebrew_prefix#g" \
  -e "s#__HOME__#$HOME#g" \
  "$repo_dir/macos/launchagents/com.marcus.dotfiles.theme-sync.plist.template" > "$launch_agent"

launchctl bootout "gui/$(id -u)" "$launch_agent" 2>/dev/null || true
launchctl bootstrap "gui/$(id -u)" "$launch_agent"
launchctl kickstart -k "gui/$(id -u)/com.marcus.dotfiles.theme-sync"
"$repo_dir/macos/sync_theme.bash"
```

- [ ] **Step 5: Verify install support without bootstrapping**

Run:

```bash
bash macos/test_theme_sync.bash
bash -n macos/install.bash
```

Expected: both commands exit 0.

- [ ] **Step 6: Commit Task 5**

Run:

```bash
git add macos/launchagents/com.marcus.dotfiles.theme-sync.plist.template macos/install.bash macos/test_theme_sync.bash
git commit -m "feat: install macos theme sync agent"
```

Expected: commit succeeds.

---

### Task 6: Full Verification And Activation

**Files:**
- No new files.
- May modify generated user files outside the repo:
  - `~/Library/LaunchAgents/com.marcus.dotfiles.theme-sync.plist`
  - `~/.local/state/dotfiles-theme/*`

**Interfaces:**
- Consumes all previous tasks.
- Produces a running local setup that follows macOS appearance.

- [ ] **Step 1: Run static verification**

Run:

```bash
bash macos/test_theme_sync.bash
fish -n fish/conf.d/zz_catppuccin_theme.fish
zsh -n zsh/theme.zsh
zsh -n zsh/.zshrc
bash -n macos/install.bash
grep -q '#EFF1F5' kitty/light-theme.auto.conf
grep -q '#1E1E2E' kitty/dark-theme.auto.conf
/Applications/Ghostty.app/Contents/MacOS/ghostty +list-themes | grep -q 'Catppuccin Latte'
/Applications/Ghostty.app/Contents/MacOS/ghostty +list-themes | grep -q 'Catppuccin Mocha'
nvim --headless '+lua print(vim.g.colors_name or "none")' +qa 2>&1 | grep -E 'catppuccin-(latte|mocha)'
```

Expected: all commands exit 0.

- [ ] **Step 2: Apply current macOS theme once**

Run:

```bash
macos/sync_theme.bash
cat "${XDG_STATE_HOME:-$HOME/.local/state}/dotfiles-theme/mode"
```

Expected: prints `light` or `dark`.

- [ ] **Step 3: Install or refresh the LaunchAgent**

Run:

```bash
homebrew_prefix="$(brew --prefix)"
launch_agent_dir="$HOME/Library/LaunchAgents"
launch_agent="$launch_agent_dir/com.marcus.dotfiles.theme-sync.plist"
mkdir -p "$launch_agent_dir" "$HOME/Library/Logs"
sed \
  -e "s#__DOTFILES_DIR__#$(pwd)#g" \
  -e "s#__HOMEBREW_PREFIX__#$homebrew_prefix#g" \
  -e "s#__HOME__#$HOME#g" \
  macos/launchagents/com.marcus.dotfiles.theme-sync.plist.template > "$launch_agent"
launchctl bootout "gui/$(id -u)" "$launch_agent" 2>/dev/null || true
launchctl bootstrap "gui/$(id -u)" "$launch_agent"
launchctl kickstart -k "gui/$(id -u)/com.marcus.dotfiles.theme-sync"
```

Expected: `bootstrap` and `kickstart` exit 0. If `dark-notify` is missing, run `brew tap cormacrelf/tap && brew install cormacrelf/tap/dark-notify`, then retry.

- [ ] **Step 4: Verify launchd sees the agent**

Run:

```bash
launchctl print "gui/$(id -u)/com.marcus.dotfiles.theme-sync" | sed -n '1,40p'
```

Expected: output includes `com.marcus.dotfiles.theme-sync`.

- [ ] **Step 5: Manual light/dark simulation without changing system settings**

Run:

```bash
macos/sync_theme.bash --mode light --skip-reload
grep -q 'DOTFILES_CATPPUCCIN_MODE=light' "${XDG_STATE_HOME:-$HOME/.local/state}/dotfiles-theme/zsh-theme.zsh"
readlink "${XDG_STATE_HOME:-$HOME/.local/state}/dotfiles-theme/tmux-theme.conf" | grep -q 'catppuccin-latte.conf'

macos/sync_theme.bash --mode dark --skip-reload
grep -q 'DOTFILES_CATPPUCCIN_MODE=dark' "${XDG_STATE_HOME:-$HOME/.local/state}/dotfiles-theme/zsh-theme.zsh"
readlink "${XDG_STATE_HOME:-$HOME/.local/state}/dotfiles-theme/tmux-theme.conf" | grep -q 'catppuccin-mocha.conf'
```

Expected: all commands exit 0.

- [ ] **Step 6: Real live-switch verification**

Manually toggle macOS Appearance in System Settings from Dark to Light or Light to Dark.

Then run:

```bash
cat "${XDG_STATE_HOME:-$HOME/.local/state}/dotfiles-theme/mode"
tail -n 20 "$HOME/Library/Logs/dotfiles-theme-sync.log" 2>/dev/null || true
tail -n 20 "$HOME/Library/Logs/dotfiles-theme-sync.err.log" 2>/dev/null || true
```

Expected: the mode file reflects the new appearance. Error log is empty or contains no fatal errors.

- [ ] **Step 7: Final status check**

Run:

```bash
git status --short --branch --untracked-files=all
```

Expected: only pre-existing unrelated changes remain, especially `M nvim/lazyvim.json` if it was still unstaged before implementation.

- [ ] **Step 8: Commit any verification-only doc updates if needed**

If no doc updates were needed, skip this step. If the plan/spec was adjusted during implementation, run:

```bash
git add docs/superpowers/specs/2026-07-24-catppuccin-system-theme-design.md docs/superpowers/plans/2026-07-24-catppuccin-system-theme.md
git commit -m "docs: update catppuccin theme sync notes"
```

Expected: commit succeeds only if docs changed.

---

## Self-Review

Spec coverage:

- Kitty native auto files are covered by Task 3.
- Ghostty native split theme is covered by Task 3.
- Neovim Catppuccin live switching is covered by Task 4.
- fish live switching through universal variable and event handler is covered by Task 2.
- zsh next-prompt switching is covered by Task 2.
- tmux live reload is covered by Task 1 and Task 2.
- `dark-notify` dependency and LaunchAgent are covered by Task 5.
- WezTerm and Linux-only pieces are explicitly excluded in Global Constraints and have no implementation task.

Placeholder scan:

- No placeholder markers or unresolved open decisions remain.

Type/interface consistency:

- The watcher writes `zsh-theme.zsh` and `tmux-theme.conf`; zsh and tmux consumers use those exact names.
- The fish watcher variable is `__dotfiles_catppuccin_mode`; the fish handler uses that exact name.
- The LaunchAgent calls `macos/sync_theme.bash`; the script exists from Task 1.
