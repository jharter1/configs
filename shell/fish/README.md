# Fish Shell Configuration

Modern, user-friendly shell configuration with plugins, custom functions, and completions.

## 📁 Structure

```text
fish/
├── config.fish          # Main configuration file
├── fish_plugins         # Fisher plugin list
├── config.fish.backup   # Backup configuration
├── completions/         # Custom tab completions
│   ├── consul.fish     # HashiCorp Consul
│   ├── docker.fish     # Docker CLI
│   ├── fisher.fish     # Fisher plugin manager
│   ├── minikube.fish   # Minikube Kubernetes
│   ├── nomad.fish      # HashiCorp Nomad
│   └── vagrant.fish    # Vagrant
├── conf.d/              # Configuration snippets
│   ├── autopair.fish   # Auto-pairing plugin config
│   └── omf.fish        # Oh My Fish remnants
└── functions/           # Custom functions
    ├── _autopair_*.fish # Auto-pairing helpers
    ├── cless.fish      # Colorized less
    ├── fisher.fish     # Fisher plugin manager
    └── man.fish        # Colorized man pages
```

## 🚀 Installation

### Prerequisites

```bash
# Install Fish (macOS with Homebrew)
brew install fish

# Add Fish to allowed shells
echo /opt/homebrew/bin/fish | sudo tee -a /etc/shells

# Set as default shell
chsh -s /opt/homebrew/bin/fish
```

### Setup Configuration

```bash
# Backup existing config if present
mv ~/.config/fish ~/.config/fish.backup

# Symlink this configuration
ln -s ~/Developer/configs/shell/fish ~/.config/fish

# Start Fish
fish
```

### Install Fisher and Plugins

```bash
# Install Fisher plugin manager
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source
fisher install jorgebucaran/fisher

# Install all plugins from fish_plugins file
fisher update
```

## 🔌 Plugins

Managed via [Fisher](https://github.com/jorgebucaran/fisher):

- **autopair.fish** - Auto-close parentheses, brackets, quotes, and strings
- **colored_man_pages.fish** - Syntax highlighting for man pages

### Adding New Plugins

```bash
fisher install <github-user>/<plugin-name>
# Example: fisher install jethrokuan/z
```

## 🛠️ Custom Functions

- `cless` - Colorized output piped to less
- `man` - Enhanced man pages with color support
- Autopair functions - Handle smart bracket/quote pairing

## 📝 Custom Completions

Tab completions for common DevOps and container tools:

- Docker
- Consul (HashiCorp)
- Nomad (HashiCorp)
- Vagrant
- Minikube
- Fisher

## 🔧 Integrations

The configuration integrates with:

- **pyenv** - Python version management
- **conda** - Anaconda/Miniconda environments
- **rbenv** - Ruby version management
- **starship** - Cross-shell prompt (config in `terminal/starship.toml`)
- **Google Cloud SDK** - gcloud CLI tools
- **kiro** - Terminal integration (if available)

### Required Tools

Install these tools separately if you need them:

```bash
# pyenv
brew install pyenv

# rbenv
brew install rbenv

# starship
brew install starship

# Google Cloud SDK
brew install --cask google-cloud-sdk
```

## 💡 Tips

### Updating Plugins

```bash
fisher update
```

### Listing Installed Plugins

```bash
fisher list
```

### Removing a Plugin

```bash
fisher remove <plugin-name>
```

### Reload Configuration

```bash
source ~/.config/fish/config.fish
```

## 🎨 Customization

Edit `config.fish` to add:

- Custom aliases
- Environment variables
- Additional function autoloads
- Shell-specific settings

Functions in `functions/` are auto-loaded by Fish, so just add new `.fish` files there.

## 🐛 Troubleshooting

### Slow Shell Startup

Check which integrations are enabled in `config.fish`. Comment out unused ones:

```fish
# eval "$(pyenv init -)"  # Disable if not using pyenv
```

### Completions Not Working

```bash
# Rebuild completions
fish_update_completions
```

### Plugin Issues

```bash
# Remove and reinstall plugins
fisher list | fisher remove
fisher update
```

## 📚 Resources

- [Fish Documentation](https://fishshell.com/docs/current/)
- [Fisher Plugin Manager](https://github.com/jorgebucaran/fisher)
- [Awesome Fish](https://github.com/jorgebucaran/awsm.fish) - Curated list of plugins
