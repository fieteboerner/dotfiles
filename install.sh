#!/bin/bash

echo "Installing dotfiles"

echo "Initializing submodule(s)"
git submodule update --init --recursive

if [ "$(uname)" == "Linux" ]; then
    echo "Running on Linux"

    echo "Update and install system packages"
    source install/linux.sh

fi

echo "Configure vim"
source install/vim.sh

echo "Setting up dotfiles"
source install/link.sh

echo "Configuring zsh as default shell"
chsh -s $(which zsh)

echo "Done."
