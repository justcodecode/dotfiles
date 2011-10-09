set nocompatible
let g:molokai_original=1
set t_Co=256
colorscheme molokai

set viminfo=%,'50,\"100,:100,n~/.vim/viminfo

set nobackup
set nowritebackup
set history=500    " keep 500 lines of command line history

set incsearch     " do incremental searching
set ignorecase
set hlsearch

syntax on
set nu
set modeline
set tabstop=4 " tab size = 4
set shiftwidth=4 " soft space = 4
set smarttab
set expandtab " expand tabs

" default to UTF-8 encoding
set encoding=utf8
set fileencoding=utf8

set laststatus=2
set statusline=   " clear the statusline for when vimrc is reloaded
set statusline+=%-3.3n\                      " buffer number
set statusline+=%f\                          " file name
set statusline+=%h%m%r%w                     " flags
set statusline+=[%{strlen(&ft)?&ft:'none'},  " filetype
set statusline+=%{strlen(&fenc)?&fenc:&enc}, " encoding
set statusline+=%{&fileformat}]              " file format
set statusline+=%=                           " right align
set statusline+=%{synIDattr(synID(line('.'),col('.'),1),'name')}\  " highlight
set statusline+=%b,0x%-8B\                   " current char
set statusline+=%-14.(%l,%c%V%)\ %<%P        " offset
