set fish_greeting

set -x LESS '--ignore-case -R'
set -x GREP_OPTIONS '--color=always'
set -x EDITOR 'vim'

eval (gdircolors -c)

alias ls='gls --color -F --group-directories-first'
alias ...='../..'
alias h='history'
alias vi='vim'
alias tree='tree -C'

set CDPATH . $HOME/depot
set PATH $PATH $HOME/depot/cloud-manager-ng-project/build/cloud-manager-ng/install/cmn/bin
