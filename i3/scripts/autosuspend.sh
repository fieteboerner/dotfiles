#! /bin/bash

# 20 min
MAXIDLETIME=1200000
SUSPEND_CMD="sudo systemctl suspend"
DISPLAY=:0

while true; do
    IDLETIME=`xprintidle`
    DPMS=`xset q | grep "DPMS is Enabled"`
    if [[ ( $IDLETIME -ge ${MAXIDLETIME%.*} ) && ( $DPMS ) ]]; then
        `$SUSPEND_CMD`
        sleep 20
    fi
    sleep 2;
done
