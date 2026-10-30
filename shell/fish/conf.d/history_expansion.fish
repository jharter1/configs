# Bash-style !! and !$, expanded as you type so you see the result before running
if status is-interactive
    abbr --add !! --position anywhere --function __history_last_command
    abbr --add '!$' --position anywhere --function __history_last_arg
end
