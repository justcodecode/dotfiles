set nocompatible

if $TERM =~ '^xterm'
    set t_Co=256
else
    set t_Co=8
endif

colorscheme monokai

set viminfo=%,'50,\"100,:100,n~/.vim/viminfo
set nobackup
set nowritebackup
set noswapfile
set history=50          " keep 50 lines of command history
set mouse=v             " use mouse in visual mode (not normal,insert,command,help mode
set clipboard=unnamed   " use system clipboard

set incsearch           " search as characters are entered
set hlsearch            " highlight matches

syntax enable
set number              " show line numbers
set modeline
set nowrap              " don't wrap lines
set scrolloff=2         " 2 lines above/below cursor when scrolling
set title               " show file in titlebar
set wildmenu            " completion with menu
set lazyredraw          " redraw only when we need to.
set showmatch           " show matching bracket (briefly jump)
set showmode            " show mode in status bar (insert/replace/...)
set showcmd             " show typed command in status bar
set ruler               " show cursor position in status bar
set cursorline          " highlight current line
set matchtime=2         " show matching bracket for 0.2 seconds
set matchpairs+=<:>     " specially for html

" editor settins
set tabstop=4           " tab size = 4
set softtabstop=4       " number of spaces in tab when editing
set shiftwidth=4        " tab at beginning uses 4 spaces
set expandtab           " expand tab to space
set ignorecase          " case insensitive searching
set smartcase           " but become case sensitive if you type uppercase characters
set smartindent         " smart auto indenting
set smarttab            " smart tab handling for indenting
set magic               " change the way backslashes are used in search patterns
set bs=indent,eol,start " allow backspacing over everything in insert mode

" default to UTF-8 encoding
set encoding=utf8
set fileencoding=utf8

set laststatus=2
set statusline=                                 " clear the statusline for when vimrc is reloaded
set statusline+=%-3.3n\                         " buffer number
set statusline+=%f\                             " file name
set statusline+=%h%m%r%w                        " flags
set statusline+=[%{strlen(&ft)?&ft:'none'},     " filetype
set statusline+=%{strlen(&fenc)?&fenc:&enc},    " encoding
set statusline+=%{&fileformat}]                 " file format
set statusline+=%=                              " right align
set statusline+=%{synIDattr(synID(line('.'),col('.'),1),'name')}\  " highlight
set statusline+=%b,0x%-8B\                      " current char
set statusline+=%-14.(%l,%c%V%)\ %<%P           " offset
