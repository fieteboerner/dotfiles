#!/bin/bash

echo "Creating vim temp directory"
mkdir -p ~/.vim-tmp

echo "Installing vundle"
mkdir -p ~/vim/bundle

cd ~/vim/bundle
git clone https://github.com/VundleVim/Vundle.vim.git

echo "Installing vundle plugins"
vim +PluginInstall +qall
