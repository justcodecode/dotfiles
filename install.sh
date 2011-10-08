#!/bin/sh
source=`dirname $0`
cp $source/.vimrc $HOME/
cp -r $source/.vim $HOME/
cp $source/.zshenv $HOME/
cp -r $source/.zsh $HOME/
