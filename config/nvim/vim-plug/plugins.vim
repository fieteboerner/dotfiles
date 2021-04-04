" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  "autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')
    " Better Comments
    Plug 'tpope/vim-commentary'
    " Repeat Commands
    Plug 'tpope/vim-repeat'
    " extend netrw (file explorer)
    Plug 'tpope/vim-vinegar'
    " helpful vim commands (:Wall, :SudoWrite, ...)
    Plug 'tpope/vim-eunuch'
    " Stable version of coc
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    " Statusline
    " Plug 'glepnir/galaxyline.nvim'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

    " Surround
    Plug 'tpope/vim-surround'
    " Auto pairs for '(' '[' '{'
    Plug 'jiangmiao/auto-pairs'
    " Have the file system follow you around
    Plug 'airblade/vim-rooter'
    " auto set indent settings
    Plug 'tpope/vim-sleuth'
    " Better Syntax Support
    Plug 'sheerun/vim-polyglot'
    " Closetags
    Plug 'alvan/vim-closetag'
    " Git
    Plug 'airblade/vim-gitgutter'
    " smooth scroll
    Plug 'psliwka/vim-smoothie'
    " multiple cursors
    Plug 'terryma/vim-multiple-cursors'
    " jump to entered character
    Plug 'easymotion/vim-easymotion'


    " Language-Server support
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    " Better Syntax Support
    Plug 'sheerun/vim-polyglot'
    " File Explorer
    " Plug 'scrooloose/NERDTree'
    " Fuzzy Finder
    Plug 'junegunn/fzf.vim'

    " Theme
    Plug 'ayu-theme/ayu-vim'

call plug#end()
