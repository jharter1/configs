# Tools

Configs for command-line tools, all linked by `setup.sh`. Like the rest of the repo they use ANSI
colour names, so they follow Ghostty's Tokyo Night light/dark.

```text
tools/
├── bat/config        # → ~/.config/bat/config
├── btop/btop.conf    # → ~/.config/btop/btop.conf
├── gh/config.yml     # → ~/.config/gh/config.yml
├── k9s/quiet.yaml    # → <k9s config dir>/skins/quiet.yaml
├── lf/lfrc           # → ~/.config/lf/lfrc
└── tmuxinator/       # → ~/.config/tmuxinator
```

## 🦇 bat

`cat` with syntax highlighting. Also used as the man pager and for `--help`
output (see `shell/fish/conf.d/bat.fish`), and for fzf previews.

Theme is `ansi`, so it follows the terminal colours (Tokyo Night). Add `--map-syntax` lines to
`config` for files bat can't identify by name.

## 🔧 GitHub CLI (`gh`)

Linked by `setup.sh`. Only `config.yml` is linked; `hosts.yml` (your login token) stays local.
Run `gh auth login` once per machine.

- **SSH** for git operations, **delta** as the pager (so `gh pr diff` looks like `git diff`)
- **Aliases:**

| Alias | Runs |
|---|---|
| `gh co 123` | `pr checkout 123` |
| `gh prs` | `pr status`: your PRs, reviews requested, current branch |
| `gh mine` | your open PRs in this repo |
| `gh review` | PRs waiting on your review |
| `gh checks` | watch CI on the current branch's PR |

`gh alias set` writes through the symlink, so new aliases land in this repo.

## 📈 btop

Linked by `setup.sh`. Uses the built-in `TTY` theme (ANSI colours, so it follows Ghostty light/dark),
a transparent background, and only the CPU, memory and process boxes. Vim keys are on.

`save_config_on_exit = False` keeps btop from rewriting the file. To keep a change made in the
btop menu, copy it into `btop.conf` by hand.

## ☸️ k9s

`quiet.yaml` is a skin in ANSI colours: grey frame and headers, a blue cursor and focus, purple for
filters, and colour in the status column only for errors (red), pending (yellow), new (cyan) and
added (green). fish sets `K9S_SKIN=quiet` to pick it.

k9s keeps its own config (`config.yaml`, cluster settings) in
`~/Library/Application Support/k9s` on macOS and rewrites it, so only the skin is linked. Run
`k9s info` to see the paths.

## 📂 lf

Terminal file manager. `lfrc` opens images, PDFs, video and audio with macOS `open`, and everything
else in nvim.

## 🎯 Tmuxinator

Linked by `setup.sh` (`~/.config/tmuxinator`). `mux` expands to `tmuxinator` in fish.
Layouts open in the **current directory**, so `cd` into a project first (except `monitor`).

| Layout | Windows |
|---|---|
| `mux default` | editor (nvim + shell), git (gitui), monitor (btop) |
| `mux devops` | editor, docker (live `docker ps` + shell), k8s (k9s), git |
| `mux infra` | editor, terraform (empty shell; nothing runs on open), k8s (k9s), monitor |
| `mux monitor` | one tiled dashboard: btop, docker, pods, shell (opens in `~`) |

Pane sizes for the `main-*` layouts come from `tmux.conf` (`main-pane-height 70%`, `main-pane-width 60%`).

```bash
mux list              # layouts
mux new myproject     # new layout in ~/.config/tmuxinator (lands in this repo)
mux debug infra       # print the tmux commands without running them
```
