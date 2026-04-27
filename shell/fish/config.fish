# Homebrew (must come first so pyenv/rbenv/starship are on PATH)
# macOS ARM: /opt/homebrew  |  Linux: /home/linuxbrew/.linuxbrew
if test (uname) = "Darwin"
    fish_add_path /opt/homebrew/bin /opt/homebrew/sbin
else if test -d /home/linuxbrew/.linuxbrew
    fish_add_path /home/linuxbrew/.linuxbrew/bin /home/linuxbrew/.linuxbrew/sbin
end

# Autosuggestion color: #6272a4 (Dracula comment purple) stands out against
# the transparent background better than the default dark gray (555 brblack).
set --global fish_color_autosuggestion '#6272a4'

if status is-interactive
    # Quick shortcuts (abbreviations expand as you type)
    abbr -a g git
    abbr -a gs git status
    abbr -a gc git commit
    abbr -a gp git push
    abbr -a gpl git pull
    abbr -a gco git checkout
    abbr -a gd git diff

    # Directory shortcuts
    abbr -a .. 'cd ..'
    abbr -a ... 'cd ../..'
    abbr -a .... 'cd ../../..'

    # Package manager update shortcut
    abbr -a brewup 'brew update && brew upgrade && brew cleanup'

    # Open current directory in file manager (platform-aware)
    if test (uname) = "Darwin"
        abbr -a o 'open .'
    else
        abbr -a o 'xdg-open .'
    end

    # Quick edit config
    abbr -a fishconfig '$EDITOR ~/.config/fish/config.fish'
    abbr -a tmuxconfig '$EDITOR ~/.config/tmux/tmux.conf'
end

# Better ls with eza (install with: brew install eza)
if command -v eza > /dev/null
    alias ls='eza --icons'
    alias ll='eza -l --icons'
    alias la='eza -la --icons'
    alias lt='eza --tree --level=2 --icons'
end

# Fast directory jumping with zoxide (install with: brew install zoxide)
if command -v zoxide > /dev/null
    zoxide init fish | source
    alias cd='z'  # Now 'cd project' jumps to most-used matching directory
end

# Better cat with bat (install with: brew install bat)
if command -v bat > /dev/null
    alias cat='bat --style=plain --paging=never'
end

# FZF - Fuzzy finder (Ctrl+R for history, Ctrl+T for files)
if command -v fzf > /dev/null
    # Use fd instead of find for faster performance
    if command -v fd > /dev/null
        set -gx FZF_DEFAULT_COMMAND 'fd --type f --hidden --follow --exclude .git'
        set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
    end
    # Better preview with bat
    set -gx FZF_CTRL_T_OPTS "--preview 'bat --color=always --style=header,grid --line-range :100 {}'"
    set -gx FZF_DEFAULT_OPTS "--color=bg+:#282a36,bg:#44475a,spinner:#f8f8f2,hl:#bd93f9,fg:#f8f8f2,header:#bd93f9,info:#8be9fd,pointer:#8be9fd,marker:#8be9fd,fg+:#f8f8f2,prompt:#bd93f9,hl+:#bd93f9 --border=rounded --prompt='🔍 ' --pointer='▶' --marker='✓'"
    # Initialize fzf key bindings
    fzf --fish | source
end

if command -v pyenv > /dev/null
    eval "$(pyenv init -)"
end
if command -v rbenv > /dev/null
    eval "$(rbenv init - fish)"
end
if test -f $HOME/anaconda3/bin/conda
    eval $HOME/anaconda3/bin/conda "shell.fish" "hook" $argv | source
end

starship init fish | source

# Lazy-load gcloud SDK (checks macOS Homebrew and Linux Homebrew paths)
set -l _gcloud_fish_inc ""
if test -f /opt/homebrew/share/google-cloud-sdk/path.fish.inc
    set _gcloud_fish_inc /opt/homebrew/share/google-cloud-sdk/path.fish.inc
else if test -f /home/linuxbrew/.linuxbrew/share/google-cloud-sdk/path.fish.inc
    set _gcloud_fish_inc /home/linuxbrew/.linuxbrew/share/google-cloud-sdk/path.fish.inc
end
if test -n "$_gcloud_fish_inc"
    function __init_gcloud
        . $_gcloud_fish_inc; functions --erase __init_gcloud
    end
    abbr -a gcloud '__init_gcloud; gcloud'
end

set PATH $PATH $HOME/.local/bin
set -gx NOMAD_ADDR http://10.0.0.50:4646
