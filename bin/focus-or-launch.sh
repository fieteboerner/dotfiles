#!/bin/bash

COMMAND=$1
APP_CLASS=$2

if hyprctl clients | grep -q "class: $APP_CLASS"; then
    hyprctl dispatch focuswindow "class:^$APP_CLASS$"
else
    $COMMAND &
fi
