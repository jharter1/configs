# Homebrew (must come first so pyenv/rbenv/starship are on PATH)
fish_add_path /opt/homebrew/bin /opt/homebrew/sbin

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

    # macOS-specific conveniences
    abbr -a brewup 'brew update && brew upgrade && brew cleanup'
    abbr -a o 'open .'  # Open current dir in Finder

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

eval "$(pyenv init -)"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f $HOME/anaconda3/bin/conda
    eval $HOME/anaconda3/bin/conda "shell.fish" "hook" $argv | source
end
# <<< conda initialize <<<

status --is-interactive; and rbenv init - fish | source

starship init fish | source

string match -q "$TERM_PROGRAM" "kiro" and . (kiro --locate-shell-integration-path fish)

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/opt/homebrew/share/google-cloud-sdk/path.fish.inc' ]; . '/opt/homebrew/share/google-cloud-sdk/path.fish.inc'; end

# GitHub token should be set via environment variable or secure storage
set -gx NOMAD_ADDR http://10.0.0.50:4646

set PATH $PATH $HOME/.local/bin

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish
