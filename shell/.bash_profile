#! /usr/bin/env bash

# Setting PATH for Python 3.7
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.7/bin:${PATH}"
export PATH


complete -C /opt/homebrew/bin/terraform terraform

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if __conda_setup="$("$HOME/anaconda3/bin/conda" 'shell.bash' 'hook' 2> /dev/null)"; then
    eval "$__conda_setup"
else
    if [ -f "$HOME/anaconda3/etc/profile.d/conda.sh" ]; then
        # shellcheck source=/dev/null
        . "$HOME/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="$HOME/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

complete -C /opt/homebrew/bin/consul consul

complete -C /opt/homebrew/bin/nomad nomad
