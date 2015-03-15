fpath=($ZDOTDIR/site-functions $fpath)

autoload compinit; compinit

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
eval $(gdircolors)
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

alias ls='gls --color -F'
alias ll='ls -l'
alias la='ll -a'
alias grep='grep --color=always'
alias dh='dirs -v'
alias ...='../..'
alias h='history'
alias less='less -R'

# Tell the terminal about the working directory whenever it changes.
if [[ "$TERM_PROGRAM" == "Apple_Terminal" ]] && [[ -z "$INSIDE_EMACS" ]]; then
  update_terminal_cwd() {
        # Identify the directory using a "file:" scheme URL, including
        # the host name to disambiguate local vs. remote paths.

        # Percent-encode the pathname.
        local URL_PATH=''
        {
            # Use LANG=C to process text byte-by-byte.
            local i ch hexch LANG=C
            for ((i = 1; i <= ${#PWD}; ++i)); do
                ch="$PWD[i]"
                if [[ "$ch" =~ [/._~A-Za-z0-9-] ]]; then
                    URL_PATH+="$ch"
                else
                    hexch=$(printf "%02X" "'$ch")
                    URL_PATH+="%$hexch"
                fi
            done
        }

        local PWD_URL="file://$HOST$URL_PATH"
        printf '\e]7;%s\a' "$PWD_URL"
    }

    # Register the function so it is called whenever the working directory changes.
    autoload add-zsh-hook
    add-zsh-hook precmd update_terminal_cwd

    # Tell the terminal about the initial directory.
    update_terminal_cwd
fi

