filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
	Plugin 'VundleVim/Vundle.vim'
	Plugin 'powerline/powerline'
	Plugin 'scrooloose/nerdtree'
    Plugin 'tpope/vim-vinegar'
    Plugin 'ctrlpvim/ctrlp.vim'
    Plugin 'rking/ag.vim'
    Plugin 'skwp/greplace.vim'
"Plugin 'c9s/perlomni.vim'
"Plugin 'c9s/cpan.vim'
"Plugin 'Valloric/YouCompleteMe'
call vundle#end()            " required
filetype plugin indent on    " required

