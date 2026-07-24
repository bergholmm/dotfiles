# Catppuccin System Theme Design

## Goal

Make the macOS development environment follow system light and dark appearance using the same Catppuccin pairing as the Codex app:

- Light mode: Catppuccin Latte
- Dark mode: Catppuccin Mocha
- Accent: Catppuccin mauve

The switch should happen live when macOS appearance changes.

## Scope

Included:

- Kitty
- Ghostty
- Neovim
- fish
- zsh
- tmux
- macOS install/link support

Excluded:

- WezTerm
- Linux-only desktop components such as Waybar, mako, wlogout, and sway

## Current State

Kitty currently includes a checked-in Cursor Dark theme through `kitty/current-theme.conf`.

Ghostty currently uses `theme = cursor-dark`.

Neovim currently loads `cursor-dark` through LazyVim config, while the Catppuccin plugin is installed but inactive. Some Neovim highlight overrides hard-code Catppuccin Mocha background values, which would break light mode if left as-is.

fish already has Catppuccin theme files and currently reports Mocha color values at runtime.

zsh relies on terminal ANSI colors and custom syntax-highlight styles. It is now a fallback shell rather than the login shell.

tmux has hard-coded Cursor Dark-like status colors.

## Architecture

Use native live-switching where the application supports it, and a small macOS watcher for tools that need an external trigger.

Kitty will use its native auto color scheme files:

- `kitty/light-theme.auto.conf` for Catppuccin Latte
- `kitty/dark-theme.auto.conf` for Catppuccin Mocha
- `kitty/no-preference-theme.auto.conf` as the light fallback

Ghostty will use its native split theme syntax:

```conf
theme = light:Catppuccin Latte,dark:Catppuccin Mocha
```

Neovim will switch active colorschemes in running sessions using `f-person/auto-dark-mode.nvim`. The light hook will set `background=light` and load `catppuccin-latte`; the dark hook will set `background=dark` and load `catppuccin-mocha`.

fish, zsh, and tmux will use a repo-owned macOS theme sync script triggered by `dark-notify`. The script will detect the current macOS appearance and apply the corresponding Catppuccin palette. tmux can be reloaded immediately. fish can use universal color variables so running shells update naturally. zsh will reload generated theme state on the next prompt through a small prompt hook.

## Components

### Kitty

Add Catppuccin Latte and Mocha auto theme files using the theme output supported by the local kitty installation. Remove or bypass the old static Cursor Dark include so auto files control the palette.

### Ghostty

Replace the single Cursor Dark theme with the built-in Catppuccin light/dark pair. The installed Ghostty version exposes all four Catppuccin built-in themes.

### Neovim

Replace the active Cursor Dark plugin configuration with Catppuccin as the active colorscheme provider. Keep Catppuccin configured for Latte and Mocha only.

Add `auto-dark-mode.nvim` with explicit light and dark hooks. Remove or make dynamic the hard-coded Mocha background overrides in bufferline/lualine config so both modes render correctly.

### fish

Use existing Catppuccin fish theme files as the palette source where practical. The macOS sync script should apply Latte or Mocha colors through fish universal variables, so active fish sessions can observe changes without restarting the terminal.

### zsh

Keep zsh support lightweight. The sync script should write a generated zsh theme snippet. `.zshrc` should source it on startup and reload it from a prompt hook if the generated file changes. This provides next-prompt switching, which is acceptable because fish is the active login shell.

### tmux

Move theme colors into generated or selected Catppuccin tmux snippets. The sync script should run `tmux source-file` for active tmux servers after switching. Existing tmux keybindings and plugin setup should remain unchanged.

### macOS Watcher

Add `dark-notify` as a Homebrew dependency in the macOS install script.

Add a LaunchAgent plist managed by the dotfiles that starts `dark-notify` at login and runs the repo theme sync script immediately and whenever macOS appearance changes.

## Data Flow

1. macOS appearance changes.
2. `dark-notify` receives the change event.
3. The LaunchAgent-managed command runs the repo sync script.
4. The script determines whether macOS is in light or dark mode.
5. The script applies or updates fish, zsh, and tmux theme state.
6. tmux reloads immediately.
7. fish observes universal variable changes.
8. zsh reloads the generated theme on the next prompt.
9. Kitty, Ghostty, and Neovim handle their own live switching through native or plugin mechanisms.

## Error Handling

If `dark-notify` is missing, install scripts should make it clear that live shell/tmux switching will not run. Static startup theming should still work.

If tmux is not running, the sync script should skip tmux reload without failing.

If fish or zsh is unavailable, the sync script should skip that shell without failing.

If macOS appearance cannot be detected, the fallback should be dark mode, matching the current environment and Catppuccin Mocha preference.

## Testing

Verify static config first:

- Kitty accepts the new auto files.
- Ghostty recognizes `Catppuccin Latte` and `Catppuccin Mocha`.
- Neovim starts headless and reports `catppuccin-latte` or `catppuccin-mocha` depending on detected appearance.
- tmux can source the generated theme snippet.
- fish can apply the generated universal variables.
- zsh can source the generated snippet.

Verify live behavior on macOS:

- Toggle macOS appearance from Dark to Light.
- Confirm Kitty and Ghostty switch palettes.
- Confirm a running Neovim session switches colors.
- Confirm tmux status colors reload.
- Confirm fish colors update in an active shell.
- Confirm zsh updates by the next prompt.

## Implementation Notes

No remaining product decisions. Implementation details should prefer small generated snippets and existing repo style over introducing a larger theme framework.
