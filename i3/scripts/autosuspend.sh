#! /bin/bash

# 20 min
MAXIDLETIME=1200000
MAXIDLETIME=2400000
SUSPEND_CMD="sudo systemctl suspend"

while true; do
    IDLETIME=`xprintidle`
    DPMS=`xset q | grep "DPMS is Enabled"`
    if [[ ( $IDLETIME -ge $MAXIDLETIME ) && ( $DPMS ) ]]; then
        `$SUSPEND_CMD`
        sleep 20
    fi
    sleep 2;
done
