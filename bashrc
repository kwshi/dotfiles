#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[[ -f ~/.bash_aliases ]] && . ~/.bash_aliases

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

export GOPATH=~/go
export PATH=$PATH:~/bin:~/go/bin


[[ "$TERM" != "dumb" ]] && [[ "$TERM" != "eterm-color" ]] && . ~/dotfiles/gruvbox_256palette.sh

