#!/bin/sh
mkdir -p $HOME/.config

# fish
cp -r fish $HOME/.config/

# vim
mkdir -p $HOME/.vim/colors
cp vim/vimrc.vim $HOME/.vimrc
cp vim/colors/monokai.vim $HOME/.vim/colors

# git
cp git/gitconfig.conf $HOME/.gitconfig

# mac
defaults write com.apple.dock tilesize -float 36
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
chflags nohidden ~/Library/
