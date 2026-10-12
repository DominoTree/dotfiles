#!/bin/sh
# Launch a random xscreensaver "hack" as eye-candy in an XWayland window.
# NOT a locker: real screen locking is handled by hyprlock.
set -eu

dir=/usr/local/bin/xscreensaver-hacks
hack=$(find "$dir" -type f -perm -u+x | sort -R | head -n1)

[ -n "$hack" ] || { echo "no xscreensaver hacks found in $dir" >&2; exit 1; }

exec "$hack"
