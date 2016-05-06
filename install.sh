#!/bin/bash

source install/helper.sh

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
        source install/base.sh
        source install/zsh.sh
        source install/vim.sh
        source install/dev-tools.sh
        source install/i3.sh
        ;;
    "base")
        source install/base.sh
        ;;
    "zsh")
        source install/zsh.sh
        ;;
    "vim")
        source install/vim.sh
        ;;
    "dev-tools")
        source install/dev-tools.sh
        ;;
    "i3")
        source install/i3.sh
        ;;
    *)
        echo "unknown ACTION"
        exit
        ;;
esac

echo "Done."
