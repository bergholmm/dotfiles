#!/bin/bash

set -e

script_dir="$(cd "$(dirname "$0")" && pwd)"
repo_dir="$(cd "$script_dir/.." && pwd)"

echo "Installing Brew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "Installing basic packages"
brew tap cormacrelf/tap
brew install fish ripgrep fzf ranger neovim direnv python python3 rustup graphviz unzip golang wget duf bat git-delta fd gnu-sed lazygit colima docker docker-Buildx coreutils curl k9s kubectx bash pnpm pyvim cormacrelf/tap/dark-notify

echo "Installing basic apps"
brew install --cask slack cursor notion kitty obsidian font-iosevka-term-nerd-font font-iosevka-nerd-font font-iosevka unnaturalscrollwheels arc raycast eurkey nordvpn

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

# Remove last login when starting new terminal
touch ~/.hushlogin
