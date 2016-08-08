#!/bin/bash

echo "Installing zsh"
if [ $OS == "linux" ]; then
   sudo apt-get install zsh 
elif [ $OS == "osx" ]; then
    sudo brew install zsh
else
    exit
fi

echo "Linking .zshrc"
ZSH_DST=$HOME/.zshrc
link $DOTFILES/zsh/zshrc.symlink $ZSH_DST

echo "Setting up oh-my-zsh"
cd $DOTFILES/
git submodule init zsh/oh-my-zsh
git submodule init zsh/custom/plugins/zsh-syntax-highlighting

echo "Configuring zsh as default shell"
sudo chsh -s $(which zsh) $USER
sudo chmod -R 755 /usr/local/share/zsh/site-functions/
