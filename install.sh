#!/bin/bash

export DOTFILES=$HOME/.dotfiles
source $DOTFILES/install/helper.sh

echo "Installing dotfiles"

if [ "$(uname)" == "Linux" ]; then
    echo "Running on Linux"
    OS="linux"

elif [ "$(uname)" == "Darwin" ]; then
    echo "Running on Mac OS X"
    OS="osx"
else
    echo "Unknown Operating System"
    exit
fi

ACTION=${1:-"ALL"}

case $ACTION in
    "ALL")
        source $DOTFILES/install/base.sh
        source $DOTFILES/install/zsh.sh
        source $DOTFILES/install/vim.sh
        source $DOTFILES/install/dev-tools.sh
        source $DOTFILES/install/i3.sh
        ;;
    "base")
        source $DOTFILES/install/base.sh
        ;;
    "zsh")
        source $DOTFILES/install/zsh.sh
        ;;
    "vim")
        source $DOTFILES/install/vim.sh
        ;;
    "dev-tools")
        source $DOTFILES/install/dev-tools.sh
        ;;
    "i3")
        source $DOTFILES/install/i3.sh
        ;;
    *)
        echo "unknown ACTION"
        exit
        ;;
esac

echo "Done."
