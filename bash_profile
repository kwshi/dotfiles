
#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc


export R_LIBS_USER=~/.r
export MATLAB_JAVA=/usr/lib/jvm/java-7-openjdk/jre
export MATLAB_LOG_DIR=~/.matlab/log

[[ -z "$DISPLAY" ]] && [[ $XDG_VTNR -eq 1 ]] && startx

