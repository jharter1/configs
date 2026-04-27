# Git Configuration

Personal Git configuration with user settings, LFS support, and platform-aware credential helper setup.

## 📄 Files

- `.gitconfig` - Main Git configuration file
- `gitconfig.linux` - Linux-specific overrides (credential helper); symlink to `~/.gitconfig.local`

## 🚀 Installation

```bash
# Symlink main configuration
ln -s ~/Developer/configs/git/.gitconfig ~/.gitconfig

# Linux only: symlink platform overrides
ln -s ~/Developer/configs/git/gitconfig.linux ~/.gitconfig.local
```

## ⚙️ Configuration

### User Information

```ini
[user]
    name = Jack Harter
    email = jack.harter@me.com
```

**Note**: Update with your own name and email before using!

### Git LFS (Large File Storage)

```ini
[filter "lfs"]
    clean = git-lfs clean -- %f
    smudge = git-lfs smudge -- %f
    process = git-lfs filter-process
    required = true
```

Git LFS is configured for handling large files. Install it if needed:

```bash
brew install git-lfs
git lfs install
```

### Pull Strategy

```ini
[pull]
    rebase = false
```

Uses merge strategy for `git pull` instead of rebase.

### Pager Settings

```ini
[pager]
    log = false
    diff = false
    branch = false
```

Disables pager for `log`, `diff`, and `branch` commands, showing full output directly in the terminal.

### Credential Helper

The main `.gitconfig` leaves `credential.helper` empty and includes `~/.gitconfig.local` for platform-specific overrides.

**macOS** — add to `~/.gitconfig.local`:
```ini
[credential]
    helper = osxkeychain
```

**Linux** — symlink the provided example:
```bash
ln -s ~/Developer/configs/git/gitconfig.linux ~/.gitconfig.local
```
This uses `git-credential-libsecret` (GNOME Keyring / KWallet). Install it on Debian/Ubuntu:
```bash
sudo apt install libsecret-1-dev git-credential-libsecret
```

## 🔧 Customization

### Adding Aliases

Add to `.gitconfig`:

```ini
[alias]
    st = status
    co = checkout
    br = branch
    ci = commit
    unstage = reset HEAD --
    last = log -1 HEAD
    visual = log --graph --oneline --all
```

### Setting Default Branch Name

```ini
[init]
    defaultBranch = main
```

### Enabling Color Output

```ini
[color]
    ui = auto
```

### Configure Editor

```ini
[core]
    editor = nvim
```

## 💡 Tips

### Check Current Configuration

```bash
# View all settings
git config --list

# View specific setting
git config user.name
```

### Override Settings Locally

For project-specific settings:

```bash
cd /path/to/project
git config user.email "work@example.com"
```

### Global vs Local Config

- `~/.gitconfig` - Global settings (this file)
- `.git/config` - Local repository settings (per project)

Local settings override global settings.

## 📚 Resources

- [Git Configuration Documentation](https://git-scm.com/docs/git-config)
- [Git LFS](https://git-lfs.github.com/)
- [GitHub: Setting up Git](https://docs.github.com/en/get-started/quickstart/set-up-git)
