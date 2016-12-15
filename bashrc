# If not running interactively, don't do anything
[[ $- != *i* ]] && return

HISTSIZE=1000
HISTFILESIZE=2000
HISTCONTROL=ignoreboth
shopt -s histappend

# Alias definitions.
alias la='ls -A'
alias ll='ls -alF'
alias l='ls -CF'
alias ls='ls --color=auto'
alias pacman='pacman --color=auto'

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

[ -r /usr/share/bash-completion/bash_completion   ] && . /usr/share/bash-completion/bash_completion
