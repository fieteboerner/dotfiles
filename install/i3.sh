#!/bin/bash

if [ $OS == "linux" ]; then
    echo "Installing i3 window manager"
    sudo apt-get install i3 i3blocks rofi feh compton

    mkdir -p ~/.config/i3
    echo "Setting up i3 config file"
    I3_DST=$HOME/.config/i3/config
    link $DOTFILES/i3/config.symlink $I3_DST

    mkdir -p ~/.config/twmn
    echo "Setting up twmn config file"
    I3_DST=$HOME/.config/twmn/twmn.conf
    link $DOTFILES/i3/twmn.conf $I3_DST

    echo "Setup .xinputrc"
fi
