autoload compinit; compinit

export EDITOR=vim

export CLICOLOR=true
PS1='%B[%n@%m:%~]%# %b'

setopt AUTOCD AUTO_LIST \
       COMPLETE_ALIASES COMPLETE_IN_WORD \
       EXTENDED_GLOB GLOB \
       HIST_EXPIRE_DUPS_FIRST HIST_IGNORE_ALL_DUPS HIST_REDUCE_BLANKS INC_APPEND_HISTORY \
       AUTOPUSHD PUSHDMINUS PUSHDSILENT PUSHDTOHOME

DIRSTACKSIZE=8
HISTSIZE=1024
SAVEHIST=1024
HISTFILE=$ZDOTDIR/zsh_history

zstyle ':completion::complete:*' use-cache true
zstyle ':completion::complete:*' cache-path $ZDOTDIR/zsh_cache
zstyle ':completion:*' verbose true
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
eval $(dircolors)
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

zstyle ':completion:*' completer _complete _list _oldlist _expand _ignored _match _correct _approximate _prefix
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3))numeric)'
zstyle ':completion:*:functions' ignored-patterns '_*'
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

zstyle ':completion:*:sudo:*' commands
zstyle ':completion:*:*:kill:*' menu true select
zstyle ':completion:*:kill:*' force-list always
zstyle ':completion:*:*:kill:*:processes' command 'ps -xco pid,user,args'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*:cd:*' ignore-parents parent pwd

alias ls='ls --color -F'
alias ll='ls -l'
alias la='ll -a'
alias grep='grep --color=always'
alias dh='dirs -v'
alias ...='../..'
alias h='history'
alias less='less -R'

