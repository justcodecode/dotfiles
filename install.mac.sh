#!/bin/sh
mkdir -p $HOME/.config

# fish
cp -r fish $HOME/.config/

# vim
mkdir -p $HOME/.vim/colors
cp vim/vimrc.vim $HOME/.vimrc
cp vim/colors/monokai.vim $HOME/.vim/colors

# lftp
cp -r lftp $HOME/.config/
