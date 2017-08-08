filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
    Plugin 'VundleVim/Vundle.vim'           " plugin manager
    Plugin 'Shougo/vimproc.vim'             " enables async progess
    Plugin 'tpope/vim-vinegar'              " extend netrw (file browsing with -)
    Plugin 'junegunn/fzf.vim'               " fuzzy file finder
    Plugin 'garbas/vim-snipmate'            " add snippet funtionality with extends funtionality
    Plugin 'tomtom/tlib_vim'                " dependency of snipmate
    Plugin 'MarcWeber/vim-addon-mw-utils'   " dependency of snipmate
    Plugin 'tpope/vim-surround'             " surrounding control 's' and 'S' to operate (rename, delete, add) with parentheses, HTML tags ...
    Plugin 'tpope/vim-sleuth'               " detect tab/spaces tabwith
    Plugin 'tpope/vim-repeat'               " enables repeat of plugin action not only built in action
    Plugin 'tpope/vim-commentary'           " gc for toggle comment selection
    Plugin 'tpope/vim-fugitive'             " git integration
    Plugin 'christoomey/vim-system-copy'    " cp can copy to system clipboard (xsel needed on linux)
    Plugin 'easymotion/vim-easymotion'      " better moving in files <leader>f
    Plugin 'vim-scripts/taglist.vim'        " list tags of file
    Plugin 'dhruvasagar/vim-table-mode'     " table plugin
    Plugin 'terryma/vim-multiple-cursors'   " multiple cursor support

    " textobjects
    Plugin 'kana/vim-textobj-user'          " base plugin for textobjects
    Plugin 'kana/vim-textobj-line'          " textobject line - l
    Plugin 'kana/vim-textobj-entire'        " textobject entire document - e
    Plugin 'kana/vim-textobj-indent'        " textobject indent - i
    Plugin 'scrooloose/syntastic'           " linter
    " languages
    Plugin 'joonty/vdebug.git'              " debugger for php, ruby, python
    Plugin 'kchmck/vim-coffee-script'       " coffeescript support
    Plugin 'evanmiller/nginx-vim-syntax'    " 
    "   ruby
    Plugin 'vim-ruby/vim-ruby'              " ruby support (omni, ... )
    Plugin 't9md/vim-ruby-xmpfilter'        " code execution inside a ruby file
    Plugin 'tpope/vim-rails'                " rails helper functions
    " typescript
    Plugin 'leafgarland/typescript-vim'     " typescript syntax highlighting and indentation
    Plugin 'Quramy/tsuquyomi'               " omni-completion for ts
    "   php
    Plugin 'StanAngeloff/php.vim'           " PHP autocomplete, syntax, ...
    Plugin 'arnaud-lb/vim-php-namespace'    " import/expand classes
    Plugin 'stephpy/vim-php-cs-fixer'       " analyzes and tries to fix coding standards (PSR-1 and PSR-2) ,pcd|,pcf
    Plugin 'shawncplus/phpcomplete.vim'     " Improved PHP omni-completion
    Plugin 'joonty/vim-phpqa'               " linter and mess detector ,qa mess ,qc code coverage

"Plugin 'c9s/perlomni.vim'
"Plugin 'c9s/cpan.vim'
call vundle#end()            " required
filetype plugin indent on    " required

