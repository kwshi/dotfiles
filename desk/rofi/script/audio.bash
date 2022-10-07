#!/bin/bash
set -euo pipefail

declare -A names
names=(
  ['hyperx']='alsa_card.usb-Kingston_HyperX_Cloud_Flight_S_000000000001-00'
  ['pc']='alsa_card.pci-0000_0e_00.4'
  ['hdmi']='alsa_card.pci-0000_0c_00.1'
  ['c920']='alsa_card.usb-046d_HD_Pro_Webcam_C920_4FDF11EF-02'
)

function profile {
  pacmd set-card-profile "${names[$1]}" "$2" || :
}

if [[ ! -v 1 ]]; then
  echo 'hyperx'
  echo 'pc'
  echo 'hdmi'
  exit
fi

case "$1" in

  'hyperx')
    profile 'hyperx' 'output:analog-stereo+input:mono-fallback'
    profile 'pc' 'off'
    profile 'hdmi' 'off'
    profile 'c920' 'off';;

  'pc')
    profile 'pc' 'output:analog-stereo'
    profile 'c920' 'input:analog-stereo'
    profile 'hyperx' 'off'
    profile 'hdmi' 'off'
    pacmd set-source-volume \
      'alsa_input.usb-046d_HD_Pro_Webcam_C920_4FDF11EF-02.analog-stereo' \
      0x08000
    ;;

  'hdmi')
    profile 'hdmi' 'output:hdmi-stereo-extra2'
    profile 'pc' 'off'
    profile 'hyperx' 'off'
    profile 'c920' 'input:analog-stereo';;

esac
