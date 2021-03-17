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

# msg "${PURPLE}\n=== Setting up networking ===${NOFORMAT}"

# sudo systemctl enable --now iwd.service
# sudo systemctl enable --now systemd-resolved.service
# sudo ln -sf /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf
sudo systemctl enable --now docker.service

# msg "${PURPLE}\n=== Installing AUR packages ===${NOFORMAT}"

# paru -S --skipreview $(cat $(chezmoi source-path)/arch/packages/aur.txt)

# msg "${PURPLE}\n=== Installing zsh plugins ===${NOFORMAT}" 

# antibody bundle < $ZDOTDIR/.zsh_plugins.txt > $ZDOTDIR/.zsh_plugins.sh 

# !!!! NOT YET DONE
# - Setup pacman hooks to share
# - Create needed create folders
# - docker without sudosudo
# sudo groupadd docker && sudo usermod -aG docker $USER && newgrp docker
# tee vielä:
# setup hooks
# omat systemctl
# kirjaa ylös toiveet tulevalle
# sit jotenkin systeemi kuntoon, kun asennan jotain tms niin jee jee, miten ne menee
# automaagisesti

# Tähän kans gpg key setup ja sen myötä passwordit
