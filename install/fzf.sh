#!/bin/bash

echo "Installing fzf"
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf

echo "Linking .fzf.zsh"
FZF_DST=$HOME/.fzf.zsh
link $DOTFILES/fzf/fzf.zsh.symlink $FZF_DST
