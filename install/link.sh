#!/bin/bash

if [ -z $DOTFILES ]; then
	DOTFILES=$HOME/.dotfiles
fi


function link {
	SRC=$1
	DST=$2
	
	if [ -L "$DST" ] ; then
		rm $DST
	fi
	if [ -f "$DST" ]; then
		mv $DST $DST.orig
	fi	
	ln -s $SRC $DST
}

echo "Linking .gitconfig"
GIT_DST=$HOME/.gitconfig
link $DOTFILES/git/gitconfig.symlink $GIT_DST

echo "Linking .vimrc"
VIM_DST=$HOME/.vimrc
link $DOTFILES/vim/vimrc.symlink $VIM_DST

echo "Linking .zshrc"
ZSH_DST=$HOME/.zshrc
link $DOTFILES/zsh/zshrc.symlink $ZSH_DST

echo "Linking .tmux.conf"
TMUX_DST=$HOME/.tmux.conf
link $DOTFILES/tmux/tmux.conf.symlink $TMUX_DST


