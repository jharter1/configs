# Neovim Configuration

Modern Neovim configuration written in Lua, featuring LSP, auto-completion, fuzzy finding, and more.

## 📁 Structure

```text
lua/
├── config/
│   └── lazy.lua          # Lazy.nvim plugin manager setup
├── core/
│   ├── autocmds.lua      # Auto-commands and event handlers
│   ├── keymaps.lua       # Key mappings and shortcuts
│   └── options.lua       # Editor options and settings
└── plugins/
    ├── completion.lua    # Auto-completion (nvim-cmp)
    ├── editor.lua        # Editor enhancements (treesitter, autopairs, etc.)
    ├── git.lua           # Git integration (gitsigns)
    ├── lsp.lua           # Language Server Protocol
    ├── navigation.lua    # File navigation (telescope, nvim-tree, oil)
    └── ui.lua            # UI enhancements (lualine, bufferline, which-key)
```

## 🚀 Installation

### Prerequisites

```bash
# Install Neovim 0.9+ (macOS)
brew install neovim

# Install optional dependencies
brew install ripgrep     # For telescope grep
brew install fd          # For telescope file finding
brew install git         # Required for lazy.nvim
```

### Setup

```bash
# Backup existing Neovim config
mv ~/.config/nvim ~/.config/nvim.backup

# Symlink this configuration
ln -s ~/Developer/configs/lua ~/.config/nvim

# Launch Neovim (plugins will auto-install)
nvim
```

On first launch, Lazy.nvim will automatically:
1. Install itself
2. Install all configured plugins
3. Set up LSP servers via Mason

## 🔌 Plugins

Managed with [Lazy.nvim](https://github.com/folke/lazy.nvim):

### Completion (`completion.lua`)
- **nvim-cmp** - Completion engine
- **LuaSnip** - Snippet engine
- **cmp-nvim-lsp** - LSP completion source
- **cmp-buffer** - Buffer completion
- **cmp-path** - Path completion

### Editor (`editor.lua`)
- **nvim-treesitter** - Syntax highlighting and parsing
- **nvim-autopairs** - Auto-close brackets and quotes
- **Comment.nvim** - Easy code commenting
- **vim-sleuth** - Auto-detect indentation

### Git (`git.lua`)
- **gitsigns.nvim** - Git decorations and hunks

### LSP (`lsp.lua`)
- **mason.nvim** - LSP installer
- **mason-lspconfig.nvim** - Mason + lspconfig integration
- **nvim-lspconfig** - LSP configurations
- **fidget.nvim** - LSP progress notifications

Preconfigured LSP servers:
- `lua_ls` - Lua
- `ts_ls` - TypeScript/JavaScript
- `eslint` - JavaScript linter
- `pyright` - Python
- `gopls` - Go
- `rust_analyzer` - Rust

### Navigation (`navigation.lua`)
- **telescope.nvim** - Fuzzy finder for files, buffers, grep, etc.
- **nvim-tree.lua** - File explorer sidebar
- **oil.nvim** - Edit filesystem like a buffer

### UI (`ui.lua`)
- **catppuccin** - Color scheme
- **lualine.nvim** - Status line
- **bufferline.nvim** - Buffer/tab line
- **indent-blankline** - Indentation guides
- **which-key.nvim** - Key binding helper

## ⌨️ Key Bindings

Leader key: `<Space>`

### General
- `<leader>w` - Save file
- `<leader>q` - Quit
- `<leader>Q` - Quit all

### File Navigation
- `<leader>ff` - Find files (Telescope)
- `<leader>fg` - Live grep (Telescope)
- `<leader>fb` - Find buffers (Telescope)
- `<leader>fh` - Find help tags (Telescope)
- `<leader>e` - Toggle file explorer (NvimTree)
- `<leader>o` - Open Oil (filesystem editor)

### LSP
- `gd` - Go to definition
- `gr` - Find references
- `K` - Hover documentation
- `<leader>ca` - Code actions
- `<leader>rn` - Rename symbol
- `[d` - Previous diagnostic
- `]d` - Next diagnostic

### Git
- `<leader>gb` - Git blame line
- `<leader>gp` - Preview hunk
- `<leader>gs` - Stage hunk
- `<leader>gr` - Reset hunk

### Buffers
- `<S-h>` - Previous buffer
- `<S-l>` - Next buffer
- `<leader>bd` - Delete buffer

See `core/keymaps.lua` for complete key bindings.

## 🎨 Customization

### Adding Plugins

Create or edit files in `plugins/`:

```lua
-- plugins/myplugin.lua
return {
  "author/plugin-name",
  config = function()
    require("plugin-name").setup({
      -- configuration
    })
  end,
}
```

Lazy.nvim will automatically load all Lua files in the `plugins/` directory.

### Changing Color Scheme

Edit `plugins/ui.lua`:

```lua
-- Replace catppuccin with your preferred theme
{ "folke/tokyonight.nvim", priority = 1000 }
```

### Adding LSP Servers

Edit `plugins/lsp.lua` and add to the `ensure_installed` list:

```lua
ensure_installed = {
  "lua_ls",
  "ts_ls",
  "your_new_server",
}
```

## 🛠️ Management

### Plugin Management

```vim
:Lazy              " Open Lazy.nvim UI
:Lazy sync         " Update all plugins
:Lazy clean        " Remove unused plugins
:Lazy restore      " Restore lockfile state
```

### LSP Management

```vim
:Mason             " Open Mason UI
:MasonInstall <server>  " Install LSP server
:MasonUninstall <server> " Uninstall LSP server
:LspInfo           " Show LSP client info
```

### Treesitter Management

```vim
:TSUpdate          " Update all parsers
:TSInstall <lang>  " Install parser for language
:TSModuleInfo      " Show installed modules
```

## 🐛 Troubleshooting

### Plugins Not Loading

```vim
:Lazy sync
:Lazy restore
```

### LSP Not Working

```vim
:LspInfo           " Check LSP status
:Mason             " Ensure servers are installed
```

### Treesitter Errors

```vim
:TSUpdate all      " Update all parsers
```

### Clear Cache

```bash
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.cache/nvim
nvim  # Restart to reinstall
```

## 📚 Resources

- [Neovim Documentation](https://neovim.io/doc/)
- [Lazy.nvim](https://github.com/folke/lazy.nvim)
- [Mason.nvim](https://github.com/williamboman/mason.nvim)
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
- [Telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
- [Learn Lua in Y minutes](https://learnxinyminutes.com/docs/lua/)

## 💡 Tips

- Press `<leader>` then wait to see available key bindings (which-key)
- Use `:checkhealth` to diagnose common issues
- All config files are hot-reloadable (`:source %`)
- Customize `core/options.lua` for editor preferences
