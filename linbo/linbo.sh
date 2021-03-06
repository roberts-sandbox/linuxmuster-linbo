#!/bin/sh
# linbo.sh - Start Linbo GUI (with optional debug shell before)
# This is a busybox 1.1.3 script
# (C) Klaus Knopper 2007
# License: GPL V2

# Reset fb color mode
RESET="]R"
# Clear and reset Screen
CLEAR="c"

CMDLINE="$(cat /proc/cmdline)"
REMOTE_TAG="### LINBO REMOTE ###"

# echo "$CLEAR$RESET"

# DEBUG
case "$CMDLINE" in *\ debug*)
 for i in /tmp/linbo_gui.*.log; do
  if [ -s "$i" ]; then
   echo "There is a log from an earlier start of linbo_gui in $i:"
   cat "$i"
   echo -n "Hit return to continue."
   read dummy
   rm -f "$i"
  fi
 done
 echo "Starting DEBUG Shell, leave with 'exit'."
 ash >/dev/tty1 2>&1 < /dev/tty1
 ;;
esac

# Start LINBO GUI
DISPLAY=""
case "$(fbset -i 2>/dev/null)" in *640\ 480\ 4*) DISPLAY="-display VGA16:0";; esac
exec linbo_gui -qws $DISPLAY >/tmp/linbo_gui.$$.log 2>&1
