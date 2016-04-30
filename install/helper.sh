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

function isLinux {
    if [ $OS == "linux" ]; then 
        return 1 
    else 
        return 0 
    fi
}

function isOsX {
    if [ $OS == "osx" ]; then 
        return 1 
    else 
        return 0 
    fi
}
