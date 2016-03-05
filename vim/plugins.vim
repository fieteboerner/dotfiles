filetype off				  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
	Plugin 'VundleVim/Vundle.vim'			" plugin manager
	Plugin 'powerline/powerline'			" status bar
	Plugin 'scrooloose/nerdtree'			" file tree browser
	Plugin 'tpope/vim-vinegar'				" extend netrw
	Plugin 'ctrlpvim/ctrlp.vim'				" file browser
	Plugin 'rking/ag.vim'					" directory serch
	Plugin 'skwp/greplace.vim'				" directory replace
	Plugin 'msanders/snipmate.vim'			" add snippet funtionality
	Plugin 'tpope/vim-surround'				" surrounding control 's' and 'S' to operate (rename, delete, add) with parentheses, HTML tags ...
	Plugin 'tpope/vim-repeat'				" enables repeat of plugin action not only built in action
	Plugin 'tpope/vim-commentary'			" gc for toggle comment selection
	Plugin 'christoomey/vim-system-copy'	" cp can copy to system clipboard (xsel needed on linux)

	Plugin 'kana/vim-textobj-user'			" base plugin for textobjects
	Plugin 'kana/vim-textobj-line'			" textobject line - l
	Plugin 'kana/vim-textobj-entire'		" textobject entire document - e
	Plugin 'kana/vim-textobj-indent'		" textobject indent - i
	" Plugin 'terryma/vim-multiple-cursors'	"multiple cursors
"Plugin 'c9s/perlomni.vim'
"Plugin 'c9s/cpan.vim'
"Plugin 'Valloric/YouCompleteMe'
call vundle#end()			" required
filetype plugin indent on	" required

