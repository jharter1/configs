function gcof --description 'Fuzzy git checkout branch'
    set branch (git branch --all --format='%(refname:short)' | \
        sed 's|origin/||' | sort -u | \
        fzf --prompt='branch: ' --height=40% --reverse)
    if test -n "$branch"
        git checkout $branch
    end
end
