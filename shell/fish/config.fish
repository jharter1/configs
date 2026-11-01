# Homebrew (must come first so pyenv/rbenv/starship are on PATH)
fish_add_path /opt/homebrew/bin /opt/homebrew/sbin

# Autosuggestion color: ANSI 7, a soft grey-blue in Tokyo Night that follows
# light/dark and reads better on the translucent background than brblack.
set --global fish_color_autosuggestion white

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

    # tmuxinator layouts (tools/tmuxinator): `mux default`, `mux infra`, ...
    abbr -a mux tmuxinator

    # Quick edit config
    abbr -a fishconfig '$EDITOR ~/.config/fish/config.fish'
    abbr -a tmuxconfig '$EDITOR ~/.config/tmux/tmux.conf'
    abbr -a nvimconfig '$EDITOR ~/.config/nvim'
end

# Better ls with eza (install with: brew install eza)
if command -v eza > /dev/null
    alias ls='eza --icons --group-directories-first'
    alias ll='eza -l --icons --group-directories-first'
    alias la='eza -la --icons --group-directories-first'
    alias lt='eza --tree --level=2 --icons --group-directories-first'
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
    set -gx FZF_DEFAULT_OPTS "--color=fg:-1,bg:-1,fg+:-1:bold,bg+:-1,hl:blue,hl+:blue,info:white,prompt:blue,pointer:magenta,marker:magenta,spinner:white,header:white,border:bright-black,gutter:-1 --border=rounded --prompt='🔍 ' --pointer='▶' --marker='✓'"
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

# A module that times out (e.g. machine busy) just drops out of the prompt;
# don't print starship's warning about it over the prompt.
set -gx STARSHIP_LOG error

# k9s skin in ANSI colours (tools/k9s/quiet.yaml)
set -gx K9S_SKIN quiet
starship init fish | source

# Transient prompt: once a command runs, its full prompt collapses to a faint
# "❯ command" with the time it ran on the right, so scrollback reads cleanly
function starship_transient_prompt_func
    set_color white; echo -n '❯ '; set_color normal
end
function starship_transient_rprompt_func
    set_color brblack; date +%H:%M; set_color normal
end
enable_transience

# Lazy-load optional integrations only if needed
test -f /opt/homebrew/share/google-cloud-sdk/path.fish.inc; and functions -q __init_gcloud; or function __init_gcloud; . /opt/homebrew/share/google-cloud-sdk/path.fish.inc; functions --erase __init_gcloud; end
abbr -a gcloud '__init_gcloud; gcloud'

set PATH $PATH $HOME/.local/bin
set -gx NOMAD_ADDR http://10.0.0.50:4646
