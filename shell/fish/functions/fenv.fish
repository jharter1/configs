function fenv --description 'Search exported env vars; copies the picked value to the clipboard'
    set -l name (set --names --export | \
        fzf --prompt='env: ' --height=60% --reverse --preview 'printenv {}' --preview-window=down,3,wrap)
    test -n "$name"; or return
    printenv $name | tr -d '\n' | pbcopy
    echo "$name="(printenv $name)"  (value copied)"
end
