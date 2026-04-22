# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

Personal macOS dotfiles managed via symlinks. No builds, tests, or package managers at the root level. The goal is portable, well-documented config files.

### Symlink targets

| Repo path | Symlink destination |
|---|---|
| `nvim/` | `~/.config/nvim/` |
| `shell/fish/` | `~/.config/fish/` |
| `shell/omf/` | `~/.config/omf/` |
| `terminal/starship.toml` | `~/.config/starship.toml` |
| `terminal/ghostty.config` | `~/.config/ghostty/config` |
| `terminal/tmux.conf` | `~/.config/tmux/tmux.conf` |
| `git/.gitconfig` | `~/.gitconfig` |
| `tools/tmuxinator/` | `~/.config/tmuxinator/` |

Always use `ln -s`, never `cp`.

## Neovim (`nvim/`)

Three-tier Lua structure:
- `lua/config/lazy.lua` — Lazy.nvim bootstrap (rarely touched)
- `lua/core/` — `options.lua`, `keymaps.lua`, `autocmds.lua`
- `lua/plugins/` — One file per category: `lsp`, `completion`, `navigation`, `ui`, `editor`, `git`

**Plugin specs** use Lazy.nvim table syntax with `opts` or `config` function.

**LSP** — Use `vim.lsp.config()` API (not the deprecated `lspconfig[server].setup()` pattern). Add servers to `ensure_installed` in `lua/plugins/lsp.lua`; Mason auto-installs on next Neovim launch.

**Keymaps** — Leader is `<Space>`. All custom mappings require a `desc` property for which-key discoverability.

**Color scheme** — Catppuccin mocha. UI plugins (lualine, bufferline, etc.) should use it.

## Shell (`shell/fish/`)

Fish is the primary shell (Zsh deprecated). Fisher manages plugins via `fish_plugins` manifest.

- `config.fish` — Main config; integrates pyenv, conda, rbenv, starship, kiro
- `functions/` — Auto-loaded by Fish; no sourcing needed
- `conf.d/` — Modular snippets, auto-loaded

**Do not modify** the conda/pyenv init blocks marked with auto-managed comments.

## Terminal (`terminal/`)

- **tmux:** Custom prefix `C-s`, 1-indexed windows, Dracula theme via TPM. Install plugins with `<prefix>I`, update with `<prefix>U`.
- **starship:** Multi-line prompt with git, Docker, k8s, Terraform contexts.
- **ghostty:** GPU-accelerated terminal.

## Git (`git/`)

- Pull strategy: merge (not rebase)
- Pager disabled for `log`, `diff`, `branch` (direct terminal output)
- Git LFS enabled
- macOS keychain credential helper

## Anti-patterns

- No hardcoded absolute paths — use `~` or env vars
- No plugins installed outside package managers (Lazy.nvim, Fisher, TPM)
- No LSP setup via old `lspconfig[server].setup()` pattern
- No keymaps without `desc` properties
- No new top-level directories without updating `README.md`
