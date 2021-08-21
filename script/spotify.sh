#!/bin/bash
set -euo pipefail

width=20

ok=1 && out="$(spotify-tui pb -s -f $'%t\n%b\n%a\n%r' 2> '/dev/null')" || ok=0
if (( ! ok )); then echo; exit; fi

readarray -t props <<< "$out"

re='s|^\([0-9]\+\):\([0-9]\+\)/\([0-9]\+\):\([0-9]\+\) .*$|\1\n\2\n\3\n\4|p'
readarray -t prog < <(sed -n "$re" <<< "${props[3]}")

ramp=(' ' '▏' '▎' '▍' '▌' '▋' '▊' '▉')
full='█'
(( val = 8 * width * (prog[0]*60 + prog[1]) / (prog[2]*60 + prog[3]) )) || :

printf '['
for ((i=0; i<val/8; ++i)); do printf '%s' "$full"; done
printf '%s' "${ramp[val%8]}"
for ((i=0; i<width-val/8; ++i)); do printf ' '; done
printf ']'


echo " ${props[0]} - ${props[1]}"

#full='██'
#
#echo "$full"
