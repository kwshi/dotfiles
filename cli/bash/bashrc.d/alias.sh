alias l='exa'
alias ll='exa -lagh'

alias g='git'
alias gs='git status'
alias gc='git commit'

alias ghostscript='/usr/bin/gs'

alias v='nvim'
alias vf='nvim "$(fzf)"'

alias c='cd'
function cf {
  if [[ -n "${1+_}" ]]; then
    cd "$(find -L "$1" -type d | fzf)"
  else
    cd "$(find -L -type d | fzf)"
  fi
}
