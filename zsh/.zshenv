# dotfiles/zsh/.zshenv
# Sourced for all zsh invocations (login + non-login + scripts).
# Keep minimal — only PATH-critical or env-required items.

# Cargo
if [[ -f "$HOME/.cargo/env" ]]; then
  source "$HOME/.cargo/env"
fi
