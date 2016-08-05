#!/bin/bash

echo "Installing tmux"
if [ $OS == "linux" ]; then
   sudo apt-get install tmux
elif  [ $OS == "osx" ]; then
    sudo brew install tmux
else
    exit
fi


 echo "Linking .tmux.conf"
 TMUX_DST=$HOME/.tmux.conf
 link $DOTFILES/tmux/tmux.conf.symlink $TMUX_DST

echo "Creating tumx plugin directory"
mkdir -p ~/.tmux/plugins

echo "Install tpm"
cd ~/.tmux/plugins
git clone https://github.com/tmux-plugins/tpm

echo "Installing vundle plugins"
tmux source ~/.tmux.conf
