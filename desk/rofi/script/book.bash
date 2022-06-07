#!/bin/bash
set -euo pipefail

if [[ -v 1 ]]; then
  coproc zathura ~/documents/books/"$1"
  exit
fi

for path in ~/documents/books/*; do echo "${path##*/}"; done
