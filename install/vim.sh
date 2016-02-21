#!/bin/bash

echo "Creating vim temp directory"
mkdir -p ~/.vim-tmp

echo "Installing vundle"
mkdir -p ~/vim/bundle

cd ~/vim/bundle
git clone https://github.com/VundleVim/Vundle.vim.git

echo "Installing vundle plugins"
vim +PluginInstall +qall

echo "Setting up color scheme"
mkdir ~/.vim/colors
cd ~/.vim/colors
wget https://raw.githubusercontent.com/gosukiwi/vim-atom-dark/master/colors/atom-dark-256.vim

echo "Installing snippets"
ln -s $DOTFILES/vim/snippets.symlink ~/.vim/snippets
