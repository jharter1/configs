# Shell

| Folder | Linked to | |
|---|---|---|
| `fish/` | `~/.config/fish` | Fish, the login shell. See [fish/README.md](fish/README.md) |
| `omf/` | `~/.config/omf` | Oh My Fish (legacy; Fisher manages plugins now) |

The prompt is Starship, configured in [`terminal/starship.toml`](../terminal/starship.toml).
Zsh and bash aren't configured here.

Make fish the login shell (once per machine; `setup.sh --all` prints this too):

```bash
echo "$(command -v fish)" | sudo tee -a /etc/shells
chsh -s "$(command -v fish)"
```
