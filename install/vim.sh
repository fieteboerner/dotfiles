#!/bin/bash

echo "Installing vim"
if [ $OS == "linux" ]; then
   sudo apt-get install vim vim-gnome
elif  [ $OS == "osx" ]; then
    sudo brew install vim gvim wget
else
    exit
fi

echo "Linking .vimrc"
VIM_DST=$HOME/.vimrc
link $DOTFILES/vim/vimrc.symlink $VIM_DST

echo "Creating vim temp directory"
mkdir -p ~/.vim-tmp
mkdir ~/.vim/undo

echo "Installing vundle"
mkdir -p ~/.vim/bundle

cd ~/.vim/bundle
git clone https://github.com/VundleVim/Vundle.vim.git

echo "Installing vundle plugins"
vim +PluginInstall +qall

echo "Setting up color scheme"
mkdir ~/.vim/colors
cd ~/.vim/colors
wget -N https://raw.githubusercontent.com/gosukiwi/vim-atom-dark/master/colors/atom-dark-256.vim

echo "Download Dictionaries"
mkdir ~/.vim/spell
cd ~/.vim/spell
wget -N http://ftp.vim.org/pub/vim/runtime/spell/en.utf-8.spl
wget -N http://ftp.vim.org/pub/vim/runtime/spell/de.utf-8.spl

echo "Installing snippets"
link $DOTFILES/vim/snippets.symlink ~/.vim/snippets
