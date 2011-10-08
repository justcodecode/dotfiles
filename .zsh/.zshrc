autoload compinit; compinit

export CLICOLOR=true
PS1='%B[%n@%m:%~]%# %b'

export PATH=$PATH:~/bin

setopt AUTOCD AUTO_LIST AUTO_MENU CORRECT_ALL \
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
zstyle ':completion:*' list-colors 'no=00:fi=00:di=34:ln=35:ex=31:pi=33:so=32:bd=34;46:cd=34;43:su=30;41:sg=30;46'

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

alias ll='ls -lF'
alias la='ll -a'
alias grep='grep --color'
alias dh='dirs -v'
alias ...='../..'
alias h='history'
