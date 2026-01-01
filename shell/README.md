# Shell Configurations

Shell configuration files for Zsh, Bash, and Fish shells.

## 📁 Contents

- `.zshrc` - Zsh configuration with Oh My Zsh and Powerlevel10k
- `.bash_profile` - Bash profile configuration
- `.p10k.zsh` - Powerlevel10k theme customization
- `fish/` - Fish shell configuration directory

## 🐚 Zsh (Oh My Zsh + Powerlevel10k)

### Installation

```bash
# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install Powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Symlink config
ln -s ~/Developer/configs/shell/.zshrc ~/.zshrc
ln -s ~/Developer/configs/shell/.p10k.zsh ~/.p10k.zsh

# Reload
source ~/.zshrc
```

### Features

- Powerlevel10k instant prompt for fast shell startup
- Custom aliases and functions
- Plugin integration

## 🐠 Fish Shell

Fish is a smart and user-friendly command line shell with syntax highlighting and autosuggestions out of the box.

### Installation

```bash
# Install Fish (macOS)
brew install fish

# Add Fish to allowed shells
echo /opt/homebrew/bin/fish | sudo tee -a /etc/shells

# Set Fish as default shell
chsh -s /opt/homebrew/bin/fish

# Symlink config directory
ln -s ~/Developer/configs/shell/fish ~/.config/fish

# Install Fisher plugin manager
fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher"

# Install plugins
fisher update
```

### Features

- **Plugin Manager**: Fisher for easy plugin management
- **Plugins**:
  - `autopair.fish` - Auto-close parentheses, brackets, quotes
  - `colored_man_pages.fish` - Colorized man pages
- **Custom Completions**: Docker, Consul, Nomad, Minikube, Vagrant
- **Custom Functions**: `cless`, `man` (colorized)
- **Integrations**: pyenv, conda, rbenv, starship, Google Cloud SDK

See [fish/README.md](fish/README.md) for detailed Fish configuration documentation.

## 🔧 Bash

Basic Bash configuration with conda initialization.

### Installation

```bash
ln -s ~/Developer/configs/shell/.bash_profile ~/.bash_profile
source ~/.bash_profile
```

## 🎨 Starship Prompt

Both Fish and Zsh configurations support [Starship](https://starship.rs/), a fast, customizable prompt.

```bash
# Install Starship
brew install starship

# Configuration is in terminal/starship.toml
```

## 🔄 Switching Shells

To switch between shells:

```bash
# Switch to Fish
chsh -s /opt/homebrew/bin/fish

# Switch to Zsh
chsh -s /bin/zsh

# Switch to Bash
chsh -s /bin/bash
```

## 📝 Notes

- All paths use `$HOME` or `~` for portability
- Some integrations (conda, pyenv, rbenv) require those tools to be installed
- Cloud SDK integration paths may need adjustment based on your installation
