#!/usr/bin/env bash

# === Global settings ===
set -Eeuo pipefail
trap 'cleanup $? $LINENO' SIGINT SIGTERM ERR EXIT
BACKTITLE="Arch Linux installation"
repo_url=https://raw.githubusercontent.com/otahontas/dotfiles/main
hostname=archis
user=otahontas

# === Helper functions ===
cleanup() {
  trap - SIGINT SIGTERM ERR EXIT
  err=$1
  line=$2
  if [ "$err" -eq 0 ]; then
    msg "${GREEN}\nInstallation script completed succesfully${NOFORMAT}"
  else
    msg "${RED}\nError happened while running installation script on line $line.${NOFORMAT}"
  fi
}

setup_colors() {
  if [[ -t 2 ]] && [[ -z "${NO_COLOR-}" ]] && [[ "${TERM-}" != "dumb" ]]; then
    NOFORMAT='\033[0m' RED='\033[0;31m' GREEN='\033[0;32m' PURPLE='\033[0;35m'
  else
    NOFORMAT='' RED='' GREEN='' PURPLE=''
  fi
}

msg() {
  echo >&2 -e "${1-}"
}

die() {
  local msg=$1
  local code=${2-1} # default exit status 1
  msg "$msg"
  exit "$code"
}

setup_colors

# === Installation === 


#!/bin/sh
echo "// Symlinking fonts folder to XDG_DATA_HOME"
dest=$XDG_DATA_HOME/fonts
[[ -e $dest ]] || ln -s $XDG_CONFIG_HOME/fonts $XDG_DATA_HOME/
echo "Done"

echo "// Symlinking pacman hooks to /usr/share/libalpm/hooks/"
destfolder=/usr/share/libalpm/hooks
for f in $XDG_CONFIG_HOME/pacman-hooks/*.hook; do
    name=$(echo $f | xargs -n 1 basename)
    [[ -e $destfolder/$name ]] || sudo ln -s $f $destfolder/
done
echo "Done"

echo "// Creating folders for HOME"
[[ -e ~/downloads ]] || mkdir ~/downloads
[[ -e ~/documents ]] || mkdir ~/documents
[[ -e ~/media ]] || mkdir ~/media
[[ -e ~/public ]] || mkdir ~/public
