#!/usr/bin/env bash

set -euo pipefail

# Dependencies we refuse to live without
deps=(apt-cache fzf pkg grep)

missing=()

for dep in "${deps[@]}"; do
  command -v "$dep" >/dev/null 2>&1 || missing+=("$dep")
done

if [ "${#missing[@]}" -ne 0 ]; then
  echo "Missing dependencies:"
  for m in "${missing[@]}"; do
    echo "  - $m"
  done
  echo
  echo "Install them first. Then come back."
  exit 1
fi

apt-cache search ".*" | fzf -e \
  --layout=reverse \
  --border-label="Ꞩurfer" \
  --border=rounded \
  --preview-label="Package details" \
  --preview-window='down,,,wrap,~1' \
  --prompt="Install package> " \
  --delimiter=' - ' \
  --with-nth=1,2 \
  --nth=1,2 \
  --preview 'apt-cache show --no-all-versions {1} | grep -Ev "^(SHA|MD5)"' \
  --bind 'enter:become(pkg install {1})'
