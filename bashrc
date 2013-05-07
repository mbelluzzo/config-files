# If not running interactively, don't do anything
[[ $- != *i* ]] && return

HISTSIZE=1000
HISTFILESIZE=2000
HISTCONTROL=ignoreboth
shopt -s histappend

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Alias definitions.
alias pacman='pacman --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Icecc setup
#export PATH=/usr/lib/icecc/bin:$PATH

qt_env_set()
{
    export PATH=$HOME/projects/qt/builds/${1:-"4.8"}/bin:$PATH
    export LIBRARY_PATH=$HOME/projects/qt/builds/${1:-"4.8"}/lib:$LIBRARY_PATH
    export LD_LIBRARY_PATH=$HOME/projects/qt/builds/${1:-"4.8"}/lib:$LD_LIBRARY_PATH
}

git_branch_get()
{
    branch=$(git symbolic-ref HEAD 2>/dev/null)
    echo -n ${branch:+" [${branch##*/}]"}
}

PS1="[\[\e[1;34m\]\u\[\e[m\e[1;32m\]@\h\[\e[m\] \W\[\e[1;33m\]\$(git_branch_get)\[\e[m\]]\$ "

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi
