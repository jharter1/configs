function __history_last_arg --description 'Expansion for !$: last argument of the previous command'
    echo -- $history[1] | read --list --tokenize tokens
    string escape -- $tokens[-1]
end
