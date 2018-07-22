#!/bin/bash


setxkbmap -layout us -variant workman

xmodmap -e 'keycode 133 = BackSpace Escape'
xmodmap -e 'remove mod4 = BackSpace'


amixer -c 0 sset 'Left Speaker Mixer Left DAC' unmute
amixer -c 0 sset 'Left Speaker Mixer Right DAC' unmute
amixer -c 0 sset 'Right Speaker Mixer Left DAC' unmute
amixer -c 0 sset 'Right Speaker Mixer Right DAC' unmute

xrdb -override .Xresources

xsetroot -cursor_name left_ptr -mod 2 2 -bg '#32302f' -fg '#1d2021'

wmname LG3D

#redshift &

exec bspwm
#exec herbstluftwm
