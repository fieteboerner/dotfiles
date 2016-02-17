filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
	Plugin 'VundleVim/Vundle.vim'           " plugin manager
	Plugin 'powerline/powerline'            " status bar
	Plugin 'scrooloose/nerdtree'            " file tree browser
    Plugin 'tpope/vim-vinegar'				" extend netrw
    Plugin 'ctrlpvim/ctrlp.vim'             " file browser
    Plugin 'rking/ag.vim'                   " directory serch
    Plugin 'skwp/greplace.vim'              " directory replace
	Plugin 'msanders/snipmate.vim'			" add snippet funtionality
	Plugin 'tpope/vim-surround'				" surrounding control 's' and 'S' to operate (rename, delete, add) with parentheses, HTML tags ...
    "Plugin 'terryma/vim-multiple-cursors'   "multiple cursors
"Plugin 'c9s/perlomni.vim'
"Plugin 'c9s/cpan.vim'
"Plugin 'Valloric/YouCompleteMe'
call vundle#end()            " required
filetype plugin indent on    " required

