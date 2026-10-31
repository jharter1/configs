#!/bin/sh
# tmux status-right: CPU and memory use. Muted when normal, yellow at 75%,
# red at 90% (same thresholds as the prompt). macOS only; prints nothing elsewhere.
[ "$(uname)" = Darwin ] || exit 0

ncpu=$(sysctl -n hw.ncpu)
cpu=$(ps -A -o %cpu= | awk -v n="$ncpu" '{ s += $1 } END { printf "%d", s / n }')

# "Used" as Activity Monitor counts it, roughly: active + wired + compressed
mem=$(vm_stat | awk -v total="$(sysctl -n hw.memsize)" '
  /page size of/            { ps = $8 }
  /^Pages active/           { a = $3 }
  /^Pages wired/            { w = $4 }
  /occupied by compressor/  { c = $5 }
  END { printf "%d", (a + w + c) * ps * 100 / total }')

tone() {
  if [ "$1" -ge 90 ]; then echo red
  elif [ "$1" -ge 75 ]; then echo yellow
  else echo white
  fi
}

printf '#[fg=%s]󰻠 %s%%  #[fg=%s]󰍛 %s%%' "$(tone "$cpu")" "$cpu" "$(tone "$mem")" "$mem"
