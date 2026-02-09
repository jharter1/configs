# AI Coding Agent Instructions for Personal Dotfiles

## Repository Overview
Personal macOS development environment configurations designed for portability via symlinks. This is **not** a traditional software project—there are no builds, tests, or package managers at the root level. Focus on maintaining clean, well-documented configuration files.

## Architecture & Organization

### Directory Structure Pattern
```
<category>/          # Top-level category (lua, shell, terminal, tools, git)
├── README.md        # Installation and setup instructions  
├── *.config         # Config files meant for symlinking
└── subdirs/         # Organized by tool or feature
```

**Key principle:** Configurations use `$HOME` or `~` paths to remain portable across machines. Symlink from `~/Developer/configs/` to expected locations like `~/.config/`.

### Neovim Configuration (`lua/`)
Modern Lua-based setup with **three-tier structure:**
- `config/lazy.lua` — Bootstrap Lazy.nvim plugin manager (minimal, rarely touched)
- `core/` — Editor fundamentals: `options.lua`, `keymaps.lua`, `autocmds.lua`
- `plugins/` — One file per category: `lsp.lua`, `completion.lua`, `navigation.lua`, `ui.lua`, `editor.lua`, `git.lua`

**Plugin pattern:** Return table of plugin specs using Lazy.nvim syntax:
```lua
return {
  { "author/plugin", opts = {}, config = function() ... end },
}
```

**LSP convention:** Use `vim.lsp.config()` API (not deprecated `lspconfig` setup). See [lsp.lua](../lua/plugins/lsp.lua#L56-L98) for examples. All servers managed via Mason (`ensure_installed` list).

**Keymaps pattern:** Use `which-key.nvim` descriptions (`desc` property) for discoverability. Leader key is `<Space>`.

**Auto-save mechanism:** [autocmds.lua](../lua/core/autocmds.lua#L9-L56) implements debounced saves with notifications. Excludes special buffers (`NvimTree`, `gitcommit`, `checkhealth`).

### Shell Configuration (`shell/fish/`)
Fish shell (deprecated Zsh in favor of Fish) managed by Fisher plugin manager:
- `config.fish` — Main config with tool integrations (pyenv, conda, rbenv, starship, kiro)
- `fish_plugins` — Fisher plugin manifest (autopair, colored man pages)
- `functions/` — Custom Fish functions (prefixed with `_` for autopair internals)
- `completions/` — Tab completions for tools (docker, consul, nomad, etc.)
- `conf.d/` — Modular config snippets loaded automatically

**Do NOT modify** conda/pyenv initialization blocks marked with auto-managed comments.

### Terminal Tools (`terminal/`)
- **tmux.conf:** Custom prefix `C-s`, 1-indexed windows, Dracula theme via TPM
- **starship.toml:** Multi-line prompt with git, Docker, k8s, Terraform contexts
- **ghostty.config:** GPU-accelerated terminal config

### Git Configuration (`git/`)
- **.gitconfig:** User info, Git LFS support, pager disabled for log/diff/branch, macOS keychain credential helper
- **Pull strategy:** Uses merge (not rebase) for `git pull`
- **No aliases configured** — vanilla Git commands preferred

### Tool Configurations (`tools/`)
Individual tool subdirectories (gh, htop, neofetch, tmuxinator) with tool-specific configs.

## Critical Workflows

### Symlink Installation Pattern
**Never** use `cp` commands. Always use symlinks:
```bash
ln -s ~/Developer/configs/lua ~/.config/nvim
ln -s ~/Developer/configs/shell/fish ~/.config/fish
```

### Neovim Plugin Updates
Lazy.nvim handles all plugin management. To add plugins:
1. Edit appropriate `plugins/*.lua` file
2. Restart Neovim or run `:Lazy sync`
3. Document in corresponding README if significant

### LSP Server Management
Add servers to `ensure_installed` in [lsp.lua](../lua/plugins/lsp.lua#L16-L29), then configure with `vim.lsp.config()`. Mason will auto-install on next launch.

## Project-Specific Conventions

### File Naming
- Lua files: lowercase with underscores (`auto_cmds.lua` → `autocmds.lua`)
- Config files: Match tool expectations (`.tmux.conf`, `config.fish`, `starship.toml`)
- READMEs: One per major directory with setup instructions

### Documentation Standard
Each category directory has:
1. **Structure** section — ASCII tree of files
2. **Installation** — Prerequisites (Homebrew formulas) and symlink commands
3. **Features/Plugins** — What's configured and why

Example: [lua/README.md](../lua/README.md#L6-L17)

### Keybinding Philosophy
- Leader (`<Space>`) + two letters for primary actions: `<leader>ff` (find files), `<leader>lg` (live grep)
- Single letter for common toggles: `<leader>e` (file tree), `<leader>o` (oil browser)
- Descriptions required for all custom mappings

### Color Scheme
Catppuccin (mocha variant) is the standard. UI plugins (lualine, bufferline) should use it.

## Common Tasks

**Adding a Neovim plugin:**
1. Identify category: navigation, LSP, UI, completion, editor, git
2. Add spec to `lua/plugins/<category>.lua`
3. Include `desc` in keymaps, configure in `config` function

**Adding Fish function:**
1. Create `shell/fish/functions/<name>.fish`
2. No sourcing needed—Fish auto-loads from functions directory

**Adding LSP server:**
1. Add to `ensure_installed` in [lsp.lua](../lua/plugins/lsp.lua#L16-L29)
2. Add config block using `vim.lsp.config("<server>", { ... })`

**Updating tmux plugins:**
Edit `tmux.conf`, prefix `C-s` + `I` to install, `U` to update via TPM.

## Integration Points

- **Starship prompt:** Configured in [starship.toml](../terminal/starship.toml), shared shell prompt
- **Tmuxinator:** Session definitions in `tools/tmuxinator/*.yml` (arnold, default, mcDowell)
- **Python:** Managed by pyenv (initialized in `config.fish`)
- **Node/Ruby:** rbenv for Ruby, system Node unless specified
- **Git:** Symlink `git/.gitconfig` to `~/.gitconfig`, pager disabled for direct terminal output, Git LFS enabled

## Anti-Patterns to Avoid

❌ Installing plugins outside package managers (use Lazy.nvim, Fisher, TPM)  
❌ Hardcoding absolute paths—use `~` or env variables  
❌ Editing auto-managed blocks (conda init, pyenv init)  
❌ Adding new top-level directories without updating main README  
❌ Keymaps without `desc` properties  
❌ LSP configs using old `lspconfig[server].setup()` pattern
