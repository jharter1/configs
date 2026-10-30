function cheat --description 'Quick examples from cheat.sh (e.g. cheat tar, cheat git rebase)'
    if test (count $argv) -eq 0
        echo "usage: cheat <command> [subcommand]" >&2
        return 1
    end
    # "git rebase" -> git-rebase, which maps to the cheat sheet rather than Q&A answers
    set -l topic (string join - -- $argv | string escape --style=url)
    curl -fsS --max-time 10 "https://cheat.sh/$topic" | less -RFX
end
