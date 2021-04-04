#!/bin/bash

echo "Linking nvim config"
NVIM_DST=$HOME/.config/nvim
ln -s $DOTFILES/config/nvim $NVIM_DST

echo "Installing Plugins"
nvim +PlugInstall

