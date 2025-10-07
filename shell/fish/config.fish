if status is-interactive
    # Commands to run in interactive sessions can go here
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
# set -gx GITHUB_PERSONAL_ACCESS_TOKEN "your-token-here"
