#!/bin/bash

# Gracefully stop Chromium and Brave
pkill -TERM chromium
pkill -TERM brave

# Optional: Give them time to exit
sleep 2

