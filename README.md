# dotfiles

My personal development environment configuration files for macOS, organized for easy management and portability.

## 📁 Structure

```text
configs/
├── lua/                    # Neovim configuration (Lua)
│   ├── config/            # Plugin manager setup
│   │   └── lazy.lua       # Lazy.nvim configuration
│   ├── core/              # Core Neovim settings
│   │   ├── autocmds.lua   # Auto commands
│   │   ├── keymaps.lua    # Key mappings
│   │   └── options.lua    # Editor options
│   └── plugins/           # Plugin configurations
│       ├── completion.lua # Auto-completion setup
│       ├── editor.lua     # Editor enhancements
│       ├── git.lua        # Git integration
│       ├── lsp.lua        # Language Server Protocol
│       ├── navigation.lua # File navigation
│       └── ui.lua         # UI enhancements
├── shell/                 # Shell configurations
│   ├── .zshrc            # Zsh with Oh My Zsh & Powerlevel10k
│   ├── .bash_profile     # Bash profile
│   ├── .p10k.zsh         # Powerlevel10k theme
│   └── fish/             # Fish shell configuration
│       ├── config.fish   # Main fish config
│       ├── fish_plugins  # Fisher plugin list
│       ├── completions/  # Custom completions
│       ├── conf.d/       # Configuration snippets
│       └── functions/    # Custom functions
├── git/                  # Git configuration
│   └── .gitconfig        # Git settings and aliases
├── terminal/             # Terminal applications
│   ├── .tmux.conf       # Tmux configuration
│   ├── .vimrc           # Vim configuration
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
# Example: Neovim
ln -s ~/Developer/configs/lua ~/.config/nvim

# Example: Fish
ln -s ~/Developer/configs/shell/fish ~/.config/fish

# Example: Git
ln -s ~/Developer/configs/git/.gitconfig ~/.gitconfig
```

See individual README files for detailed setup instructions.

## 📚 Documentation

- [lua/](lua/README.md) - Neovim configuration
- [shell/](shell/README.md) - Shell configurations (zsh, bash, fish)
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
