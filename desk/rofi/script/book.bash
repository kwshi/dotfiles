#!/bin/bash
set -euo pipefail

if [[ -v 1 ]]; then
  coproc zathura ~/documents/books/"$1".pdf
  exit
fi

for path in ~/documents/books/*; do
  name="${path##*/}"
  name="${name%%.pdf}"
  echo "$name"
done
