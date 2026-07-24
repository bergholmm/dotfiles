#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
STATE_DIR="$STATE_HOME/dotfiles-theme"
MODE=""
DRY_RUN=0
SKIP_RELOAD=0

usage() {
  printf 'Usage: %s [light|dark] [--mode light|dark] [--dry-run] [--skip-reload]\n' "$0" >&2
}

set_mode() {
  if [[ -n "$MODE" && "$MODE" != "$1" ]]; then
    printf 'Conflicting modes: %s and %s\n' "$MODE" "$1" >&2
    exit 2
  fi
  MODE="$1"
}

while (($#)); do
  case "$1" in
    --mode)
      if [[ -z "${2:-}" ]]; then
        usage
        exit 2
      fi
      set_mode "$2"
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
    light|dark)
      set_mode "$1"
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
