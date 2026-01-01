# Development Tools Configuration

Configuration files for various development and system tools.

## 📁 Contents

```text
tools/
├── gh/              # GitHub CLI
│   └── config.yml
├── htop/            # Process monitor
│   └── htoprc
├── neofetch/        # System info display
│   └── config.conf
└── tmuxinator/      # Tmux session manager
    ├── arnold.yml
    └── mcDowell.yml
```

## 🔧 GitHub CLI (`gh`)

Official GitHub command-line tool.

### Installation

```bash
# Install gh
brew install gh

# Authenticate
gh auth login

# Symlink configuration
mkdir -p ~/.config/gh
ln -s ~/Developer/configs/tools/gh/config.yml ~/.config/gh/config.yml
```

### Configuration

- **Git Protocol**: SSH (for clone, push, pull)
- **Prompt**: Enabled for interactive workflows
- **Aliases**:
  - `co` → `pr checkout` (checkout pull request)

### Usage Examples

```bash
# Create PR
gh pr create

# Checkout PR
gh co 123  # Using alias

# View repo
gh repo view

# List issues
gh issue list
```

## 📊 htop

Interactive process viewer, better than `top`.

### Installation

```bash
# Install htop
brew install htop

# Symlink configuration
mkdir -p ~/.config/htop
ln -s ~/Developer/configs/tools/htop/htoprc ~/.config/htop/htoprc

# Run
htop
```

### Features

The configuration includes custom columns, colors, and display settings optimized for development workflows.

## 🎨 neofetch

System information display tool with ASCII art.

### Installation

```bash
# Install neofetch
brew install neofetch

# Symlink configuration
mkdir -p ~/.config/neofetch
ln -s ~/Developer/configs/tools/neofetch/config.conf ~/.config/neofetch/config.conf

# Run
neofetch
```

### What It Displays

- OS and kernel
- Host model
- Uptime
- Packages installed
- Shell
- Display resolution
- Desktop environment
- Window manager
- CPU and GPU
- Memory usage
- ASCII art logo

### Customization

Edit `neofetch/config.conf` to:
- Add/remove information lines
- Change ASCII art
- Modify colors
- Add custom info blocks

## 🎯 Tmuxinator

Tmux session manager with predefined layouts.

### Installation

```bash
# Install tmuxinator
brew install tmuxinator

# Create config directory
mkdir -p ~/.config/tmuxinator

# Symlink configurations
ln -s ~/Developer/configs/tools/tmuxinator/arnold.yml ~/.config/tmuxinator/arnold.yml
ln -s ~/Developer/configs/tools/tmuxinator/mcDowell.yml ~/.config/tmuxinator/mcDowell.yml
```

### Projects

#### arnold

Project template located at `~/`.

```bash
# Start arnold session
tmuxinator start arnold

# Or use alias
mux arnold
```

#### mcDowell

Custom project session (check file for specific configuration).

```bash
# Start mcDowell session
tmuxinator start mcDowell
```

### Creating New Projects

```bash
# Create new project
tmuxinator new myproject

# Edit existing project
tmuxinator edit arnold

# List projects
tmuxinator list

# Delete project
tmuxinator delete myproject
```

### Example Project Structure

```yaml
name: myproject
root: ~/Developer/myproject

windows:
  - editor:
      layout: main-vertical
      panes:
        - nvim
        - git status
  - server:
      panes:
        - npm run dev
  - console:
      panes:
        - fish
```

## 💡 Tips

### GitHub CLI

```bash
# Set default editor for gh
gh config set editor nvim

# View all config
gh config list

# Enable/disable auto-update
gh config set prompt disabled
```

### Neofetch in Shell Profile

Add to your shell config to display on terminal startup:

```fish
# Fish: ~/.config/fish/config.fish
if status is-interactive
    neofetch
end
```

```zsh
# Zsh: ~/.zshrc
neofetch
```

### Tmuxinator Aliases

Add to shell config:

```fish
# Fish
alias mux='tmuxinator'
```

```zsh
# Zsh
alias mux='tmuxinator'
```

## 🔄 Updating Configurations

After modifying config files in this repo:

```bash
# Changes are automatically reflected (symlinked)
# Just restart the application

# For gh
gh config list

# For htop
# Just restart htop

# For neofetch
neofetch

# For tmuxinator
tmuxinator list
```

## 📚 Resources

- [GitHub CLI Manual](https://cli.github.com/manual/)
- [htop Documentation](https://htop.dev/)
- [Neofetch Wiki](https://github.com/dylanaraps/neofetch/wiki)
- [Tmuxinator Documentation](https://github.com/tmuxinator/tmuxinator)

## 🛠️ Additional Tools to Consider

Other development tools you might want to add configs for:

- **direnv** - Environment variable management per directory
- **asdf** - Multi-language version manager
- **k9s** - Kubernetes CLI manager
- **lazygit** - Terminal UI for git
- **bat** - Cat clone with syntax highlighting
- **fzf** - Fuzzy finder
