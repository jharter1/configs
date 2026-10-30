function fcd --description 'Fuzzy-jump into a subfolder (fcd [start dir])'
    set -l root (test -n "$argv[1]"; and echo $argv[1]; or echo .)
    set -l dir (fd --type d --hidden --exclude .git . $root | \
        fzf --prompt='cd: ' --height=60% --reverse \
            --preview 'eza --tree --level=1 --icons --color=always {}')
    test -n "$dir"; and builtin cd $dir
end
