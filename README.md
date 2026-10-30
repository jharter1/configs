# dotfiles

A quiet, Tokyo Night–themed macOS terminal setup: Ghostty, fish, Starship, tmux and Neovim.
Built on the idea that the computer isn't the thing, it's how you get to the thing.
Colour only shows up when something needs your attention.

## 🚀 New machine in one command

Needs [Homebrew](https://brew.sh) (which also installs the Xcode command-line tools).

```bash
git clone https://github.com/jharter1/configs.git ~/Developer/configs && ~/Developer/configs/setup.sh --all
```

That does everything in order:

1. **Packages:** `brew bundle` from the [`Brewfile`](Brewfile), covering fish, starship, neovim, tmux, Ghostty, the IBM Plex Nerd Font, bat, eza, fzf, fd, delta and more
2. **Symlinks:** every config into `~/.config` (anything already there is backed up as `*.bak.<timestamp>`)
3. **Plugins:** Fisher (fish), TPM (tmux), Lazy.nvim (Neovim)

Then four one-time steps, which the script prints at the end too:

```bash
echo "$(command -v fish)" | sudo tee -a /etc/shells && chsh -s "$(command -v fish)"  # fish as login shell
gh auth login                    # GitHub CLI + SSH key
```

- Open Ghostty, or reload it with `cmd+shift+,`, to pick up the theme and font.
- Put machine-specific git settings (work email, credential helper) in `~/.gitconfig.local`.

**Only want the symlinks?** Run `./setup.sh` with no flag. It's safe to re-run at any time; existing links are skipped.

**Updating:** `git pull && ./setup.sh --all` installs anything new from the Brewfile and syncs plugins. Once `.gitconfig` is linked, GitHub URLs go over SSH, so run `gh auth login` before your first `git pull`.

## ✨ What you get

### Prompt (Starship)

```
╭─  jwh@tekdeck ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈ 󰚥 80% 󰖔 01:31
├─  configs on  main 󰋚 3m [!2] +82/-64
╰─ ❯
```

- **Muted by default.** The frame, clock, battery and commit age stay grey. Colour is reserved for uncommitted changes, errors, low battery, sudo, memory pressure and VPN.
- **Shown only when relevant:**
  - memory (above 75%) and VPN, when connected
  - uptime, after 7 days
  - k8s context, in Kubernetes folders only (production contexts turn red)
  - AWS, only when a profile is active
- **Readable git:**
  - the path starts at the repo root
  - how long ago the last commit was
  - compact status: `[+staged !modified ?untracked ⇡ahead]`
- **Transient prompt.** Past commands collapse to a faint `❯ command` with the time they ran, so scrollback reads like a transcript.

### Shell (fish)

| Command | What it does |
|---|---|
| `cheat tar`, `cheat git rebase` | Practical examples from cheat.sh |
| `sudo !!`, `vim !$` | Bash-style last command / last argument, expanded as you type |
| `fcd [dir]` | Fuzzy-jump into any subfolder (tree preview) |
| `fkill [9]` | Fuzzy-pick processes to kill (tab for several) |
| `fenv` | Search env vars; copies the picked value |
| `gcof` | Fuzzy git checkout with a branch-graph preview |
| `cmd --help␣` | Expands to `--help \| bat`, highlighted help |

**Also built in:**
- **Greeting:** one line when a shell opens, e.g. `󰖔 Good evening, jwh · Fri 30 Oct · 󰁹 80%`.
- **Done notifications:** commands over 30 seconds send a macOS notification when they finish, if the terminal isn't focused. Success is silent; a failure plays a sound.
- **Readable output:** man pages and `bat` share one syntax-highlighting style. `ls` lists folders first. `cat` stays plain for clean copy-paste.

### Terminal, tmux and editor

- **Ghostty:** Tokyo Night that follows macOS light/dark (Moon / Day). IBM Plex Mono (Blex Nerd Font), translucent background.
- **One palette everywhere.** The prompt, tmux, fish, fzf, bat and delta use ANSI colour names rather than hex, so they switch with Ghostty automatically.
- **tmux:** prefix `ctrl-s`, splits on `|` and `-`, and a one-line status bar with the session name and window list. `prefix` lights up only while you're holding the prefix key. `ctrl-s o` opens the fuzzy session switcher.
- **Neovim:** Lua config with LSP (Mason), completion, Telescope, and Tokyo Night Moon/Day. The start screen (`nvim` with no file) has recent files, projects and one-key shortcuts.
- **git:** delta for every diff, merge (not rebase) on pull, LFS, SSH for GitHub URLs.

## 📁 Structure

```text
configs/
├── Brewfile              # Everything setup.sh --all installs
├── setup.sh              # Symlinks (+ packages and plugins with --all)
├── nvim/                 # → ~/.config/nvim
├── shell/
│   ├── fish/             # → ~/.config/fish   (config.fish, functions/, conf.d/)
│   └── omf/              # → ~/.config/omf
├── terminal/
│   ├── ghostty.config    # → ~/.config/ghostty/config
│   ├── starship.toml     # → ~/.config/starship.toml
│   └── tmux.conf         # → ~/.config/tmux/tmux.conf
├── git/.gitconfig        # → ~/.gitconfig
└── tools/
    ├── bat/              # → ~/.config/bat
    ├── tmuxinator/       # → ~/.config/tmuxinator
    ├── gh/  htop/  lf/  neofetch/   # reference configs (not linked by setup.sh)
```

More detail per area:
- nvim: layout and conventions in [CLAUDE.md](CLAUDE.md#neovim-nvim)
- [shell](shell/README.md)
- [git](git/README.md)
- [terminal](terminal/README.md)
- [tools](tools/README.md)

## 🛠️ Requirements

- macOS on Apple silicon or Intel, with [Homebrew](https://brew.sh)
- Everything else comes from the Brewfile

CI on Linux checks that `setup.sh` links everything and that the fish, tmux and shell scripts parse ([`linux-ci.yml`](.github/workflows/linux-ci.yml)).
