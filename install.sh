#!/bin/sh
source=`dirname $0`
files=".vimrc .vim .zshenv .zsh .gitconfig"
for file in $files; do
    cp -r $source/$file $HOME/
done
