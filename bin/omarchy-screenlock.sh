#!/bin/bash

MODE="${1:-status}"
FILE="${HOME}/.local/state/screenlock-disabled"

is_screenlock_disabled() {
    [[ -f "$FILE" ]] && grep -q '1' $FILE
}

case "$MODE" in
    lock)
        if is_screenlock_disabled; then
            echo "Screen locking is disabled."
            exit 0
        fi

        echo "Locking the screen..."
        loginctl lock-session
        ;;
    toggle)
        if is_screenlock_disabled; then
            echo "0" > "$FILE"
            exit 0
        fi
        echo "1" > "$FILE"
        ;;
    status)
        if is_screenlock_disabled; then
            echo "Screen locking is disabled."
        else
            echo "Screen locking is enabled."
        fi
        ;;
    *)
        echo "Usage: $0 {lock|toggle|status}"
        exit 1
        ;;
esac
