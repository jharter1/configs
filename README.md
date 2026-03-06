# dotfiles

My personal development environment configuration files for macOS, organized for easy management and portability.

## 📁 Structure

```text
configs/
├── nvim/                   # Neovim configuration
│   ├── init.lua           # Entry point
│   └── lua/               # Lua modules
│       ├── config/        # Plugin manager setup
│       │   └── lazy.lua   # Lazy.nvim configuration
│       ├── core/          # Core Neovim settings
│       │   ├── autocmds.lua   # Auto commands
│       │   ├── keymaps.lua    # Key mappings
│       │   └── options.lua    # Editor options
│       └── plugins/       # Plugin configurations
│           ├── completion.lua # Auto-completion setup
│           ├── editor.lua     # Editor enhancements
│           ├── git.lua        # Git integration
│           ├── lsp.lua        # Language Server Protocol
│           ├── navigation.lua # File navigation
│           └── ui.lua         # UI enhancements
├── shell/                 # Shell configurations
│   ├── fish/              # Fish shell configuration
│   │   ├── config.fish   # Main fish config
│   │   ├── fish_plugins  # Fisher plugin list
│   │   ├── completions/  # Custom completions
│   │   ├── conf.d/       # Configuration snippets
│   │   └── functions/    # Custom functions
│   └── omf/              # Oh My Fish configuration
│       ├── bundle        # Installed packages
│       ├── channel       # Release channel
│       └── theme         # Active theme
├── git/                  # Git configuration
│   └── .gitconfig        # Git settings and aliases
├── terminal/             # Terminal applications
│   ├── ghostty.config   # Ghostty terminal
│   ├── tmux.conf        # Tmux configuration
│   └── starship.toml    # Starship prompt
└── tools/                # Development tools
    ├── gh/              # GitHub CLI
    ├── htop/            # Process monitor
    ├── neofetch/        # System info display
    └── tmuxinator/      # Tmux session manager
```

## 🚀 Quick Start

Each subdirectory contains its own README with specific setup instructions. These configurations are designed to be portable and use `$HOME` and `~` where possible.

### Installation

Most configurations can be symlinked to their expected locations:

```bash
# Neovim
ln -s ~/Developer/configs/nvim ~/.config/nvim

# Fish
ln -s ~/Developer/configs/shell/fish ~/.config/fish

# Oh My Fish
ln -s ~/Developer/configs/shell/omf ~/.config/omf

# Starship
ln -s ~/Developer/configs/terminal/starship.toml ~/.config/starship.toml

# Git
ln -s ~/Developer/configs/git/.gitconfig ~/.gitconfig
```

See individual README files for detailed setup instructions.

## 📚 Documentation

- [nvim/](nvim/README.md) - Neovim configuration
- [shell/](shell/README.md) - Shell configurations (fish, omf)
- [git/](git/README.md) - Git configuration
- [terminal/](terminal/README.md) - Terminal tools (tmux, vim, starship)
- [tools/](tools/README.md) - Development tools

## 💡 Features

- **Neovim**: Modern Lua-based configuration with LSP, completion, and Git integration
- **Fish Shell**: Fast, user-friendly shell with custom functions and completions
- **Zsh**: Oh My Zsh with Powerlevel10k theme
- **Tmux**: Terminal multiplexer with sensible defaults
- **Starship**: Fast, customizable prompt for any shell

## 🛠️ Requirements

- macOS (primary target)
- Neovim 0.9+ (for lua configs)
- Fish 3.0+ or Zsh 5.0+
- Git 2.0+
- Tmux 3.0+ (optional)

## 📝 License

Feel free to use and adapt these configurations for your own setup!
