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

echo "Configure Server Flag for Hostname"
read -p "Is this a server installation? [y/N]: " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
   sudo sh -c "echo 'export ZSH_IS_SERVER=1' >> /etc/profile"
fi

