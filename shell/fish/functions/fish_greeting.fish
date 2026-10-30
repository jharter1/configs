# One-line hello on new shells: time-of-day, date, battery, uptime
function fish_greeting
    set -l h (date +%H)
    if test $h -ge 5 -a $h -lt 12
        set -f icon 󰖜; set -f part morning
    else if test $h -ge 12 -a $h -lt 17
        set -f icon 󰖙; set -f part afternoon
    else if test $h -ge 17 -a $h -lt 22
        set -f icon 󰖛; set -f part evening
    else
        set -f icon 󰖔; set -f part evening
    end

    set -l battery (pmset -g batt 2>/dev/null | string match -r '\d+%')
    set -l boot (sysctl -n kern.boottime | string match -r 'sec = (\d+)')[2]
    set -l days (math --scale=0 "($(date +%s) - $boot) / 86400")

    # Muted to match the prompt frame; only the greeting itself is brighter
    set_color white; echo -n "$icon "
    set_color normal; echo -n "Good $part, jwh"
    set_color white
    echo -n " · "(date '+%a %d %b')
    test -n "$battery"; and echo -n " · 󰁹 $battery"
    echo " · 󰐥 up $days"d
    set_color normal
end
