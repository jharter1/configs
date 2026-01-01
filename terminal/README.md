# Terminal Configuration

Terminal application configurations for Tmux, Vim, and Starship prompt.

## 📄 Files

- `.tmux.conf` - Tmux terminal multiplexer configuration
- `.vimrc` - Vim editor configuration
- `starship.toml` - Starship cross-shell prompt configuration

## 🖥️ Tmux

Terminal multiplexer that allows multiple terminal sessions in a single window.

### Installation

```bash
# Install tmux
brew install tmux

# Install TPM (Tmux Plugin Manager)
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Symlink configuration
ln -s ~/Developer/configs/terminal/.tmux.conf ~/.tmux.conf

# Start tmux and install plugins
tmux
# Press Ctrl-s + I (capital i) to install plugins
```

### Key Features

- **Custom Prefix**: `Ctrl-s` (instead of default `Ctrl-b`)
- **Live Reload**: `Ctrl-s + r` to reload configuration
- **Mouse Support**: Enabled for scrolling and pane selection
- **Status Bar**: Top position with Dracula theme
- **256 Color Support**: Full color terminal

### Plugins

Managed via [TPM](https://github.com/tmux-plugins/tpm):

- **tmux-sensible** - Sensible default settings
- **tmux-battery** - Battery status display
- **tmux-resurrect** - Save/restore sessions
- **tmux-continuum** - Automatic session saving
- **dracula/tmux** - Dracula color theme

### Dracula Status Bar

Shows:
- Git status
- Network bandwidth (on `en0` interface)
- Battery level
- CPU usage
- RAM usage
- Weather
- Time

### Plugin Management

```bash
# Install plugins
Ctrl-s + I

# Update plugins
Ctrl-s + U

# Uninstall plugins (remove from config first)
Ctrl-s + alt + u
```

## 📝 Vim

Minimal Vim configuration.

### Installation

```bash
# Symlink configuration
ln -s ~/Developer/configs/terminal/.vimrc ~/.vimrc
```

### Features

- Syntax highlighting enabled

**Note**: For a full-featured editor, use the Neovim configuration in [lua/](../lua/README.md).

## ✨ Starship

Fast, customizable prompt for any shell (Fish, Zsh, Bash).

### Installation

```bash
# Install Starship
brew install starship

# Symlink configuration
mkdir -p ~/.config
ln -s ~/Developer/configs/terminal/starship.toml ~/.config/starship.toml

# Add to your shell config:
# Fish: Already configured in shell/fish/config.fish
# Zsh: Add to .zshrc: eval "$(starship init zsh)"
# Bash: Add to .bashrc: eval "$(starship init bash)"
```

### Features

#### Custom Multi-line Format

```
┌───────────────────> username@hostname                                  🔋 100% ⌚ 14:30
│~/Developer/configs ⚡ main +1 *2
│🐋 docker ⛵ k8s-context
└─> ✔
```

#### Prompt Components

**Line 1 (Status)**:
- Username and hostname (always shown)
- Battery status (desktop users can disable)
- Current time

**Line 2 (Directory & Git)**:
- Current directory (truncated to 3 levels)
- Git branch with lightning symbol ⚡
- Git status indicators:
  - `+` staged files (green)
  - `*` modified files (yellow)
  - `?` untracked files (red)
- Git metrics (insertions/deletions)

**Line 3 (Context)**:
- Docker context 🐋
- Kubernetes cluster ⛵
- Terraform workspace 🚜
- Vagrant status

**Line 4 (Input)**:
- Command duration (if > 1s)
- Success/error indicator: ✔/✗

#### Cloud & DevOps Tools

- **Azure**: Shows subscription (disabled by default)
- **Google Cloud**: Shows account/project (disabled by default)
- **Kubernetes**: Shows context and namespace
- **Terraform**: Shows workspace
- **Vagrant**: Shows status
- **Docker**: Shows context (disabled by default)

#### Customization

Edit `starship.toml`:

```toml
# Enable/disable Docker context
[docker_context]
disabled = false

# Disable battery on desktop
[battery]
disabled = true

# Change directory truncation
[directory]
truncation_length = 5
```

### Testing Changes

```bash
# Reload shell or:
source ~/.config/fish/config.fish  # Fish
source ~/.zshrc                     # Zsh
```

## 🎨 Color Schemes

- **Tmux**: Dracula theme
- **Starship**: Custom colors (green, purple, yellow, red)

## 💡 Tips

### Tmux Session Management

```bash
# Create named session
tmux new -s mysession

# List sessions
tmux ls

# Attach to session
tmux attach -t mysession

# Detach from session
Ctrl-s + d
```

### Tmux Pane Navigation

```bash
# Split panes
Ctrl-s + %    # Horizontal split
Ctrl-s + "    # Vertical split

# Navigate panes
Ctrl-s + arrow keys

# Resize panes (hold Ctrl-s)
Ctrl-s + (arrow keys)
```

### Starship Performance

Starship is async and won't slow down your prompt. If you experience slowness:

```toml
# Reduce timeout
scan_timeout = 300
command_timeout = 1000
```

## 🐛 Troubleshooting

### Tmux Colors Not Working

Ensure terminal supports 256 colors:

```bash
echo $TERM
# Should show "tmux-256color" inside tmux
```

### Tmux Plugins Not Loading

```bash
# Reinstall TPM
rm -rf ~/.tmux/plugins/tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# In tmux: Ctrl-s + I
```

### Starship Not Showing

Ensure it's initialized in shell config:

```fish
# Fish (check ~/.config/fish/config.fish)
starship init fish | source
```

```zsh
# Zsh (check ~/.zshrc)
eval "$(starship init zsh)"
```

## 📚 Resources

- [Tmux Manual](https://man.openbsd.org/tmux.1)
- [TPM Documentation](https://github.com/tmux-plugins/tpm)
- [Dracula Tmux Theme](https://draculatheme.com/tmux)
- [Starship Documentation](https://starship.rs/)
- [Starship Configuration](https://starship.rs/config/)
