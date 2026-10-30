function fkill --description 'Fuzzy-pick processes to kill (tab to multi-select; fkill 9 for SIGKILL)'
    set -l sig (test -n "$argv[1]"; and echo $argv[1]; or echo TERM)
    set -l pids (ps -u (id -u) -o pid,%cpu,%mem,comm | \
        fzf --multi --header-lines=1 --prompt="kill -$sig: " --height=60% --reverse \
            --preview 'ps -o pid,ppid,etime,command -p {1}' --preview-window=down,3,wrap | \
        awk '{print $1}')
    test -n "$pids"; or return
    kill -$sig $pids; and echo "Sent SIG$sig to $pids"
end
