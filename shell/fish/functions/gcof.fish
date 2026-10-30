function gcof --description 'Fuzzy git checkout branch (with log preview)'
    set branch (git branch --all --format='%(refname:short)' | \
        sed 's|origin/||' | sort -u | \
        fzf --prompt='branch: ' --height=60% --reverse \
            --preview 'git log --oneline --graph --color=always -20 {} 2>/dev/null; or git log --oneline --graph --color=always -20 origin/{}')
    if test -n "$branch"
        git checkout $branch
    end
end
