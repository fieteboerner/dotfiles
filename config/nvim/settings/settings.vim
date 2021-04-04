set iskeyword+=-                        " treat dash separated words as a word text object"
set formatoptions-=cro                  " Stop newline continution of comments

syntax enable                           " Enables syntax highlighing
set autoread                            " read files if changed on file system
set encoding=utf-8                      " The encoding displayed
set pumheight=10                        " Makes popup menu smaller
set fileencoding=utf-8                  " The encoding written to file
set ruler                               " Show the cursor position all the time
set cmdheight=2                         " More space for displaying messages
set mouse=a                             " Enable your mouse
set t_Co=256                            " Support 256 colors
set conceallevel=0                      " So that I can see `` in markdown files
set laststatus=2                        " Always display the status line
set number                              " Line numbers
set cursorline                          " Enable highlighting of the current line
set nobackup                            " This is recommended by coc
set nowritebackup                       " This is recommended by coc
set shortmess+=c                        " Don't pass messages to |ins-completion-menu|.
set signcolumn=yes                      " Always show the signcolumn, otherwise it would shift the text each time
set updatetime=300                      " Faster completion
set timeoutlen=250                      " By default timeoutlen is 1000 ms
set scrolloff=2                         " minimum lines above/below cursor

"-------command line--------"
set wildmenu                            " enhanced command line completion
set hidden                              " current buffer can be put into background
set showcmd                             " show incomplete commands
set wildmode=list:longest               " complete files like a shell
set shellcmdflag=-ic                    " ignorecase => makes shell interactive => enables aliases

"-------tab stops-------"
set tabstop=4                           " size of a hard tabstop
set shiftwidth=4                        " size of an indent
set softtabstop=4                       " a combination of spaces and tabs are used to simulate tabstops at a width
set expandtab                           " Convert tabs to spaces
set smarttab                            " Makes tabbing smarter will realize you have 2 vs 4
set smartindent                         " Makes indenting smart
set autoindent                          " Good auto indent

"-------code folding-------"
set foldmethod=syntax                       " fold based on indent
set foldnestmax=10                          " deepest fold is 10 levels
set nofoldenable                            " don't fold by default
set foldlevel=1

"-------line wrapping-------"
set wrap                                    " turn on line wrapping
set wrapmargin=8                            " wrap lines when coming within n characters from side
set linebreak                               " set soft wrapping
set showbreak=…                             " show ellipsis at breaking
set whichwrap+=<,>,[,],h,l

"-------show invisible spaces-------"
set list
set listchars=tab:»\ ,trail:•,extends:»,precedes:«

"-------Search-------"
set incsearch                               " start search by typing
set showmatch                               " show matching braces
set nohlsearch                              " don't show all occurrences of search term -> see mapping for toggle

"-------Split Management-------"
set splitbelow                              " Make splits default to below...
set splitright                              " And to the right. This feels more natural.


"-------Undo Directory-------"
set undofile
set undodir=~/.config/nvim/undo

"-------Theme settings-------"
set termguicolors     " enable true colors support
let ayucolor="light"
colorscheme ayu
