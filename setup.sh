#!/usr/bin/env bash
# setup.sh — link (and optionally install) everything in this repo.
#
#   ./setup.sh          symlinks only (safe to re-run; existing files are backed up)
#   ./setup.sh --all    Homebrew packages + symlinks + fish/tmux/nvim plugins (macOS)
#
# Run from anywhere; uses the script's directory as the repo root.

set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ALL=false
[ "${1:-}" = "--all" ] && ALL=true

step() { printf '\n\033[34m==>\033[0m %s\n' "$1"; }

link() {
  local src="$1"
  local dst="$2"

  if [ -L "$dst" ]; then
    echo "skip  $dst (already a symlink)"
    return
  fi

  if [ -e "$dst" ]; then
    local backup
    backup="${dst}.bak.$(date +%Y%m%d%H%M%S)"
    echo "back  $dst -> $backup"
    mv "$dst" "$backup"
  fi

  mkdir -p "$(dirname "$dst")"
  ln -s "$src" "$dst"
  echo "link  $dst -> $src"
}

# ── 1. Packages ──────────────────────────────────────────────────────────────
if $ALL; then
  step "Homebrew packages (Brewfile)"
  if ! command -v brew >/dev/null; then
    echo "Homebrew not found. Install it first: https://brew.sh" >&2
    exit 1
  fi
  brew bundle --file="$REPO/Brewfile"
fi

# ── 2. Symlinks ──────────────────────────────────────────────────────────────
step "Symlinks"
link "$REPO/nvim"                      "$HOME/.config/nvim"
link "$REPO/shell/fish"                "$HOME/.config/fish"
link "$REPO/shell/omf"                 "$HOME/.config/omf"
link "$REPO/terminal/starship.toml"    "$HOME/.config/starship.toml"
link "$REPO/terminal/ghostty.config"   "$HOME/.config/ghostty/config"
link "$REPO/terminal/tmux.conf"        "$HOME/.config/tmux/tmux.conf"
link "$REPO/git/.gitconfig"            "$HOME/.gitconfig"
link "$REPO/tools/tmuxinator"          "$HOME/.config/tmuxinator"
link "$REPO/tools/bat"                 "$HOME/.config/bat"

# ── 3. Plugins ───────────────────────────────────────────────────────────────
if $ALL; then
  # The linked .gitconfig rewrites https://github.com/ to SSH, which fails on a
  # fresh machine with no SSH key yet. Plugin clones skip the global config.
  export GIT_CONFIG_GLOBAL=/dev/null

  step "Fish plugins (Fisher)"
  fish -c 'fisher update' || echo "warn  fisher update failed; run it later in fish"

  step "tmux plugins (TPM)"
  TPM="$HOME/.config/tmux/plugins/tpm"
  [ -d "$TPM" ] || git clone --depth 1 https://github.com/tmux-plugins/tpm "$TPM"
  "$TPM/bin/install_plugins" || echo "warn  TPM install failed; press <prefix> I inside tmux"

  step "Neovim plugins (Lazy.nvim)"
  nvim --headless "+Lazy! sync" +qa || echo "warn  Lazy sync failed; open nvim and run :Lazy sync"

  step "Git LFS"
  unset GIT_CONFIG_GLOBAL   # this one should write to the real ~/.gitconfig
  git lfs install --skip-repo >/dev/null && echo "ok"
fi

# ── Done ─────────────────────────────────────────────────────────────────────
step "Done"
if $ALL; then
  cat <<'EOF'
Remaining one-time steps:
  1. Make fish your login shell:
       echo "$(command -v fish)" | sudo tee -a /etc/shells
       chsh -s "$(command -v fish)"
  2. Open Ghostty (or reload with cmd+shift+,) to pick up the theme and font.
  3. gh auth login            # GitHub CLI + SSH key upload
  4. Machine-specific git settings (email, credential helper) go in ~/.gitconfig.local
EOF
else
  echo "Open a new shell to apply changes. For packages and plugins too: ./setup.sh --all"
fi
