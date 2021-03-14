#!/usr/bin/env bash

# Bootstrap script for setting up a new arch linux

# === Global settings ===
set -Eeuo pipefail
trap 'cleanup $? $LINENO' SIGINT SIGTERM ERR EXIT
script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P)

# === Helper functions ===
cleanup() {
  trap - SIGINT SIGTERM ERR EXIT
  err=$1
  line=$2
  if [ "$err" -eq 0 ]; then
    msg "${GREEN}\nInstallation script completed succesfully"
  else
    msg "${RED}\nError happened while running installation script on line $2.${NOFORMAT}\nAfter you've fixed the error, you can safely re-run the script. It will skip parts that have been already performed."
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
