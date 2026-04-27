#!/usr/bin/env bash
# setup.sh — create symlinks for all dotfiles
# Run from anywhere; uses the script's directory as the repo root.

set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

link() {
  local src="$1"
  local dst="$2"

  if [ -L "$dst" ]; then
    echo "skip  $dst (already a symlink)"
    return
  fi

  if [ -e "$dst" ]; then
    local backup="${dst}.bak.$(date +%Y%m%d%H%M%S)"
    echo "back  $dst -> $backup"
    mv "$dst" "$backup"
  fi

  mkdir -p "$(dirname "$dst")"
  ln -s "$src" "$dst"
  echo "link  $dst -> $src"
}

link "$REPO/nvim"                      "$HOME/.config/nvim"
link "$REPO/shell/fish"                "$HOME/.config/fish"
link "$REPO/shell/omf"                 "$HOME/.config/omf"
link "$REPO/terminal/starship.toml"    "$HOME/.config/starship.toml"
link "$REPO/terminal/ghostty.config"   "$HOME/.config/ghostty/config"
link "$REPO/terminal/tmux.conf"        "$HOME/.config/tmux/tmux.conf"
link "$REPO/git/.gitconfig"            "$HOME/.gitconfig"

# On Linux, symlink the platform-specific credential helper config
if [ "$(uname)" != "Darwin" ]; then
  link "$REPO/git/gitconfig.linux" "$HOME/.gitconfig.local"
fi

echo ""
echo "Done. Open a new shell to apply changes."
