# Basic
alias n='nvim'

# Tailscale wrapper (GUI app binary)
tailscale() { /Applications/Tailscale.app/Contents/MacOS/Tailscale "$@"; }

# Claude Code shortcuts
C() { claude --dangerously-skip-permissions "$@"; }
clauded() { claude --dangerously-skip-permissions "$@"; }
