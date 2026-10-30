# macOS notification when a long command finishes while the terminal isn't focused
set --query notify_long_threshold; or set --global notify_long_threshold 30000 # ms

# Interactive programs that would always trip the threshold
set --query notify_long_ignore; or set --global notify_long_ignore nvim vim ssh tmux man less top htop btop lazygit fzf

function __notify_long_on_postexec --on-event fish_postexec
    set -l code $status
    test "$CMD_DURATION" -ge $notify_long_threshold; or return
    contains -- (string split -f1 ' ' -- $argv[1]) $notify_long_ignore; and return

    set -l front (osascript -e 'tell application "System Events" to get name of first process whose frontmost is true' 2>/dev/null)
    string match -qi -r 'ghostty|iterm|terminal|wezterm|kitty|alacritty' -- $front; and return

    set -l secs (math --scale=0 $CMD_DURATION / 1000)
    set -l took (math --scale=0 $secs / 60)m(math $secs % 60)s
    test $secs -lt 60; and set took {$secs}s

    if test $code -eq 0
        set -f title "✓ Finished in $took"
    else
        set -f title "✘ Failed ($code) after $took"
    end
    osascript -e 'on run argv' \
        -e 'display notification (item 1 of argv) with title (item 2 of argv) sound name "Glass"' \
        -e 'end run' -- $argv[1] $title &>/dev/null &
    disown 2>/dev/null
end
