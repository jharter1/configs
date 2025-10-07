# Configuration Files

A collection of my development environment configuration files, organized for easy management and sharing.

## 📁 Structure

```text
configs/
├── shell/           # Shell configurations
│   ├── .zshrc       # Zsh shell config with Oh My Zsh & Powerlevel10k
│   ├── .bash_profile # Bash profile with conda setup
│   ├── .p10k.zsh    # Powerlevel10k theme configuration
│   └── fish/        # Fish shell configuration
├── git/             # Git configuration
│   └── .gitconfig   # Git settings and aliases
├── terminal/        # Terminal applications
│   ├── .tmux.conf   # Tmux configuration with plugins
│   ├── .vimrc       # Vim configuration
│   └── starship.toml # Starship prompt configuration
└── tools/           # Development tools
    ├── gh/          # GitHub CLI configuration
    ├── htop/        # Htop process monitor config
    ├── neofetch/    # System info display config
    ├── op/          # 1Password CLI configuration
    ├── tmuxinator/  # Tmux session configurations
    └── argocd/      # ArgoCD configuration
```

## 🚀 Usage

These configurations are designed to be portable across different systems. Hardcoded paths have been replaced with `$HOME` and `~` where possible.

Feel free to copy and adapt these configurations for your own use!
