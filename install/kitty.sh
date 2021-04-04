#!/bin/bash


echo "Linking kitty config"
KITTY_DST=$HOME/.config/kitty
ln -s $DOTFILES/config/kitty $KITTY_DST
ln -s themes/ayu_light.conf $KITTY_DST/theme.conf
