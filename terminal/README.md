# Terminal

| File | Linked to |
|---|---|
| `ghostty.config` | `~/.config/ghostty/config` |
| `starship.toml` | `~/.config/starship.toml` |
| `tmux.conf` | `~/.config/tmux/tmux.conf` |
| `tmux-status.sh` | `~/.config/tmux/status.sh` (CPU/RAM for the tmux bar) |

All linked by `setup.sh`. Colours everywhere are ANSI names, not hex, so they follow Ghostty's
theme: `TokyoNight Moon` in dark mode, `TokyoNight Day` in light mode.

## 👻 Ghostty

- **Theme:** Tokyo Night Moon / Day, switching with macOS appearance
- **Font:** IBM Plex Mono (`BlexMono Nerd Font`, the non-Mono build so icons aren't squeezed), 15 pt,
  SemiBold for bold, 10% taller cells and icons
- **Window:** 80% opacity with blur, 10 px padding, tabs in the title bar
- **Behaviour:** fish shell integration, copy on select, option key as alt, no close confirmation

Ghostty doesn't reload on save. Press `cmd+shift+,`. Check the file with
`ghostty +validate-config`. Comments must be on their own line.

## ✨ Starship

Three-line prompt, muted by default. Colour appears only for uncommitted changes, errors, low
battery, sudo, memory pressure and VPN.

```
╭─  jwh@tekdeck ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈ 󰚥 80% 󰖔 01:31
├─  configs on  main 󰋚 3m [!2] +82/-64
╰─ ❯
```

- **Line 1:** user@host, then sudo, jobs, nested shells, memory (over 75%) and VPN, but only when
  relevant. On the right: uptime (after 7 days), battery, a time-of-day icon and the clock.
- **Line 2:** the path starting at the repo root, branch, last-commit age, git status and line counts.
- **Line 3:** last exit status, how long the command took, `❯`.
- **Right side:** language versions, Docker, k8s (Kubernetes folders only; prod contexts in red) and
  AWS (only with a profile).
- Past prompts collapse to `❯ command` (transient prompt, set up in `config.fish`).

Custom modules (VPN, uptime, time of day, commit age) are short shell commands with a 500 ms limit.
On a busy machine one may skip a prompt; that's expected. Check speed with `starship timings`.
Colours come from the `quiet` palette at the end of the file (`frame`, `muted`), which must stay
the last table in the file.

## 🖥️ tmux

| Keys | Does |
|---|---|
| `ctrl-s` | Prefix |
| `ctrl-s \|` / `ctrl-s -` | Split side by side / top and bottom (keeps the current folder) |
| `shift-←` / `shift-→` | Previous / next window (no prefix) |
| `ctrl-s o` | Fuzzy session switcher (sessionx) |
| `ctrl-s r` | Reload the config |
| `ctrl-s I` / `ctrl-s U` | Install / update plugins (TPM) |

- Windows and panes start at 1. Windows are named after the folder, or the running command.
- Mouse on; vi copy mode copies to the macOS clipboard.
- `main-*` layouts give the main pane 70% height / 60% width (used by tmuxinator).
- **Plugins** (TPM, in `~/.config/tmux/plugins`): sensible, resurrect (saves panes and nvim
  sessions; auto-restore off), continuum, sessionx.

**Status bar** (top):
- **Left:** the session name in a blue pill.
- **Middle:** windows; the current one is a purple pill, and zoomed windows get a 󰊓.
- **Right:** CPU and RAM, muted until 75% (yellow) or 90% (red), from `tmux-status.sh` every 5
  seconds. `prefix` appears while the prefix key is held, and `󰌘 ssh` while the current pane is
  connected to another machine.

Git, battery and time already live in the prompt, so the bar doesn't repeat them.

**Plugins missing?** `git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm`,
then `ctrl-s I`. `setup.sh --all` does this.
