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

echo "Checking dark-notify positional mode"
XDG_STATE_HOME="$state_dir" macos/sync_theme.bash light --dry-run --skip-reload | grep -q "mode=light"

echo "Checking generated light state"
XDG_STATE_HOME="$state_dir" macos/sync_theme.bash --mode light --skip-reload
grep -q "DOTFILES_CATPPUCCIN_MODE=light" "$state_dir/dotfiles-theme/zsh-theme.zsh"
test -L "$state_dir/dotfiles-theme/tmux-theme.conf"
readlink "$state_dir/dotfiles-theme/tmux-theme.conf" | grep -q "catppuccin-latte.conf"
test -f "$(readlink "$state_dir/dotfiles-theme/tmux-theme.conf")"

echo "Checking generated dark state"
XDG_STATE_HOME="$state_dir" macos/sync_theme.bash --mode dark --skip-reload
grep -q "DOTFILES_CATPPUCCIN_MODE=dark" "$state_dir/dotfiles-theme/zsh-theme.zsh"
readlink "$state_dir/dotfiles-theme/tmux-theme.conf" | grep -q "catppuccin-mocha.conf"
test -f "$(readlink "$state_dir/dotfiles-theme/tmux-theme.conf")"

if command -v tmux >/dev/null 2>&1; then
  echo "Checking tmux theme files"
  tmux -L dotfiles-theme-test -f /dev/null new-session -d
  trap 'tmux -L dotfiles-theme-test kill-server 2>/dev/null || true; rm -rf "$state_dir"' EXIT
  tmux -L dotfiles-theme-test source-file tmux/themes/catppuccin-latte.conf
  tmux -L dotfiles-theme-test source-file tmux/themes/catppuccin-mocha.conf
  tmux -L dotfiles-theme-test kill-server
fi

echo "Checking LaunchAgent template"
test -f macos/launchagents/com.marcus.dotfiles.theme-sync.plist.template
rendered_plist="$state_dir/com.marcus.dotfiles.theme-sync.plist"
sed \
  -e "s#__DOTFILES_DIR__#$repo_dir#g" \
  -e "s#__HOMEBREW_PREFIX__#/opt/homebrew#g" \
  -e "s#__HOME__#$HOME#g" \
  macos/launchagents/com.marcus.dotfiles.theme-sync.plist.template > "$rendered_plist"
plutil -lint "$rendered_plist" >/dev/null

echo "theme sync checks passed"
