# Git Configuration

| File | Linked to |
|---|---|
| `.gitconfig` | `~/.gitconfig` |
| `.gitignore_global` | `~/.gitignore_global` (`core.excludesfile`) |

Both are linked by `setup.sh`.

## What's set

- **delta** pages every diff, log and `git add -p` (`ansi` theme, so it follows Tokyo Night).
- **Pull merges** (`pull.rebase = false`). `push.default = current` pushes the branch you're on.
- **SSH for GitHub:** `https://github.com/` URLs are rewritten to `git@github.com:`.
- **Git LFS** filters.

Quiet quality-of-life defaults:

| Setting | Effect |
|---|---|
| `init.defaultBranch = main` | New repos start on `main` |
| `fetch.prune`, `fetch.pruneTags` | Branches/tags deleted on the remote disappear locally |
| `diff.algorithm = histogram` | Cleaner diffs when code moves around |
| `diff.colorMoved = default` | Moved lines are coloured differently from real changes |
| `merge.conflictstyle = zdiff3` | Conflicts show the original text too, without repeated lines |
| `rerere.enabled` | Git remembers how you resolved a conflict and reuses it |
| `branch.sort = -committerdate` | `git branch` lists recent branches first |
| `tag.sort = -version:refname` | `git tag` lists newest versions first |
| `rebase.autosquash` | `git fixup <sha>` commits fold in on the next `git rebase -i` |
| `column.ui = auto` | Branch/tag lists use columns when they fit |
| `help.autocorrect = prompt` | Typos like `git stauts` offer the right command |

Aliases: `git fixup <sha>`, `git recent` (last 10 branches), `git aliases`.

## Machine-specific settings

`.gitconfig` includes `~/.gitconfig.local`, which isn't in the repo. Put anything that differs per machine there, such as a work email:

```bash
git config --file ~/.gitconfig.local user.email you@work.example
```

The credential helper lives there too. The shared file sets `helper =` (empty) to clear any default, and on macOS `setup.sh` writes `helper = osxkeychain` to `~/.gitconfig.local`.
