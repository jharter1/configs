# Fish

Linked to `~/.config/fish` by `setup.sh`. Fish is the login shell; zsh and bash are not configured.

```text
fish/
├── config.fish     # PATH, abbreviations, tool integrations, prompt
├── fish_plugins    # Fisher manifest (fisher, autopair, sponge)
├── fish_variables  # Fish's own state (Fisher bookkeeping); don't hand-edit
├── conf.d/         # Auto-loaded snippets
├── functions/      # Auto-loaded functions, one per file
└── completions/    # Extra tab completions (docker, consul, nomad, minikube, vagrant)
```

## Plugins (Fisher)

| Plugin | What it does |
|---|---|
| `jorgebucaran/fisher` | The plugin manager itself |
| `jorgebucaran/autopair.fish` | Closes brackets and quotes as you type |
| `meaningful-ooo/sponge` | Keeps typos and failed commands out of history |

`fisher update` installs/updates everything in `fish_plugins` (`setup.sh --all` runs it).
`fisher install owner/repo` adds one and records it in the manifest. Plugin files land in
`functions/` and `conf.d/` inside this repo. Fisher and autopair are committed, so a symlink-only
setup still has them; sponge's files are git-ignored and come from `fisher update`.

## config.fish

- **Abbreviations** (expand as you type): `g`, `gs`, `gc`, `gp`, `gpl`, `gco`, `gd`; `..`, `...`; `brewup`; `o` (Finder);
  `mux` (tmuxinator); `fishconfig`, `tmuxconfig`, `nvimconfig`
- **eza** for `ls` / `ll` / `la` / `lt`, folders first
- **zoxide** replaces `cd`: `cd proj` jumps to the most-used matching folder
- **bat** replaces `cat`, plain style (clean copy-paste)
- **fzf** with fd for files and bat for previews: `ctrl-r` history, `ctrl-t` files, `alt-c` folders
- **pyenv, rbenv, conda** initialised when installed. The conda block is auto-managed; leave it alone
- **gcloud** loads on first use, so it doesn't slow down startup
- **Starship** prompt with transient mode, plus `STARSHIP_LOG=error` so a slow module just drops out quietly
- `K9S_SKIN=quiet` (see `tools/k9s/`)

## functions/

| Function | What it does |
|---|---|
| `fish_greeting` | One quiet line on startup: time of day, date, battery, uptime after a week |
| `cheat <topic>` | Examples from cheat.sh, e.g. `cheat tar`, `cheat git rebase` |
| `fcd [dir]` | Fuzzy-jump into a subfolder, with a tree preview |
| `fkill [signal]` | Fuzzy-pick processes to kill (tab selects several) |
| `fenv` | Search environment variables; copies the chosen value |
| `gcof` | Fuzzy git checkout with a branch-graph preview |
| `pip` | Always `python3 -m pip` |

## conf.d/

| File | What it does |
|---|---|
| `bat.fish` | bat as the man pager; `cmd --help␣` expands to `--help \| bat` |
| `history_expansion.fish` | `!!` and `!$` expand to the last command / last argument |
| `notify_long.fish` | macOS notification when a command over 30 s finishes while the terminal is in the background. Silent on success, sound on failure. Full-screen apps (nvim, k9s, btop, ...) are skipped |
| `omf.fish` | Loads Oh My Fish if present (legacy) |
| `fish_frozen_*.fish` | Written by fish 4.3 when it moved theme/key-binding variables out of universal scope; leave as is |
| `autopair.fish`, `sponge.fish` | Plugin files (Fisher) |

## Adding things

- New function: `functions/<name>.fish` containing one `function <name>` (fish loads it on first use).
- New startup snippet: `conf.d/<name>.fish`.
- Machine-only settings (secrets, work paths): put them in `conf.d/local.fish`, which is git-ignored.
