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

# GitHub over SSH: the linked .gitconfig sends all github.com URLs through SSH,
# so pulls/pushes need a key GitHub knows about. Warn (don't fail) if missing.
SSH_OK=false
check_ssh() {
  # GitHub exits 1 even on success, so capture first and match the greeting
  local out
  out="$(ssh -T -o BatchMode=yes -o ConnectTimeout=5 -o StrictHostKeyChecking=accept-new \
           git@github.com 2>&1 || true)"
  if grep -q "successfully authenticated" <<<"$out"; then
    SSH_OK=true
    echo "ok    GitHub SSH works"
  else
    printf '\033[33mwarn\033[0m  GitHub SSH is not set up yet. Setup continues, but git pull/push will fail until it is.\n'
  fi
}

ssh_instructions() {
  cat <<'EOF'

  Set up GitHub SSH:
    ssh-keygen -t ed25519 -C "you@example.com"   # accept the default path; set a passphrase
    ssh-add --apple-use-keychain ~/.ssh/id_ed25519
    gh auth login                                 # choose SSH; it offers to upload the key
  Check it:
    ssh -T git@github.com                         # "Hi <user>! You've successfully authenticated"
EOF
}

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

step "GitHub SSH"
check_ssh
$SSH_OK || ssh_instructions

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
link "$REPO/zed"                       "$HOME/.config/zed"
link "$REPO/shell/fish"                "$HOME/.config/fish"
link "$REPO/shell/omf"                 "$HOME/.config/omf"
link "$REPO/terminal/starship.toml"    "$HOME/.config/starship.toml"
link "$REPO/terminal/ghostty.config"   "$HOME/.config/ghostty/config"
link "$REPO/terminal/tmux.conf"        "$HOME/.config/tmux/tmux.conf"
link "$REPO/terminal/tmux-status.sh"   "$HOME/.config/tmux/status.sh"
link "$REPO/git/.gitconfig"            "$HOME/.gitconfig"
link "$REPO/git/.gitignore_global"     "$HOME/.gitignore_global"
link "$REPO/tools/tmuxinator"          "$HOME/.config/tmuxinator"
link "$REPO/tools/bat"                 "$HOME/.config/bat"
link "$REPO/tools/lf/lfrc"             "$HOME/.config/lf/lfrc"
link "$REPO/tools/btop/btop.conf"      "$HOME/.config/btop/btop.conf"
link "$REPO/tools/gh/config.yml"       "$HOME/.config/gh/config.yml"
# k9s keeps its config under Application Support on macOS; skin picked by K9S_SKIN
if [ "$(uname)" = "Darwin" ]; then K9S_DIR="$HOME/Library/Application Support/k9s"; else K9S_DIR="$HOME/.config/k9s"; fi
link "$REPO/tools/k9s/quiet.yaml"      "$K9S_DIR/skins/quiet.yaml"

# Machine-specific git settings live in ~/.gitconfig.local (included by the
# shared .gitconfig). On macOS, use the Keychain for credentials unless a
# helper is already set there.
if [ "$(uname)" = "Darwin" ] && ! git config --file "$HOME/.gitconfig.local" --get credential.helper >/dev/null 2>&1; then
  git config --file "$HOME/.gitconfig.local" credential.helper osxkeychain
  echo "set   ~/.gitconfig.local credential.helper = osxkeychain"
fi

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
if ! $SSH_OK; then
  printf '\033[33m!!\033[0m    GitHub SSH still is not set up. Do this first:\n'
  ssh_instructions
  echo
fi
if $ALL; then
  cat <<'EOF'
Remaining one-time steps:
  1. Make fish your login shell:
       echo "$(command -v fish)" | sudo tee -a /etc/shells
       chsh -s "$(command -v fish)"
  2. Open Ghostty (or reload with cmd+shift+,) to pick up the theme and font.
  3. gh auth login            # GitHub CLI (and SSH key upload, if not done)
  4. Machine-specific git settings (e.g. work email) go in ~/.gitconfig.local
EOF
else
  echo "Open a new shell to apply changes. For packages and plugins too: ./setup.sh --all"
fi
