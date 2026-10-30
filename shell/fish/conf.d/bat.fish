# Route man pages and --help output through bat for consistent highlighting
command -q bat; or return

set -gx MANPAGER "sh -c 'col -bx | bat --language=man --plain'"
set -gx MANROFFOPT -c

if status is-interactive
    # `git --help ` expands to `git --help | bat -plhelp`
    abbr --add --position anywhere -- --help '--help | bat --plain --language=help'
end
