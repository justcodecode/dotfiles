#!/bin/sh

# zsh
mkdir -p $HOME/.zsh/site-functions
cp zsh/zshenv.zsh $HOME/.zshenv
cp zsh/zshrc.mac.zsh $HOME/.zsh/.zshrc
cp zsh/site-functions/_vagrant.zsh $HOME/.zsh/site-functions/_vagrant
ln -s /usr/local/Library/Contributions/brew_zsh_completion.zsh $HOME/.zsh/site-functions/_brew

# vim
mkdir -p $HOME/.vim/colors
cp vim/vimrc.vim $HOME/.vimrc
cp vim/colors/monokai.vim $HOME/.vim/colors

