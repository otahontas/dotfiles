#!/usr/bin/env bash

# Bootstrap script for setting up a new macos

# TODO: Add setting system preferences via commands
# TODO: Add restore app settings from backups

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

# Ensure localhost is the one I use
[[ $(scutil --get ComputerName) == "mahisbook" ]] || sudo scutil --set ComputerName mahisbook
[[ $(scutil --get LocalHostName) == "mahisbook" ]] || sudo scutil --set LocalHostName mahisbook

# Enable FireVault
fdesetup status | grep -q "FileVault is On" || sudo fdesetup enable

# Setup firewall
fw_changed="false"
if ! /usr/libexec/ApplicationFirewall/socketfilterfw --getglobalstate | grep -q "Firewall is enabled"; then
  sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on
  fw_changed=true
fi
if ! /usr/libexec/ApplicationFirewall/socketfilterfw --getloggingmode | grep -q "Log mode is on"; then
  sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setloggingmode on
  fw_changed=true
fi
if ! /usr/libexec/ApplicationFirewall/socketfilterfw --getstealthmode | grep -q "Stealth mode enabled"; then
  sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setstealthmode on
  fw_changed=true
fi
[[ "$fw_changed" == "true" ]] && sudo pkill -HUP socketfilterfw && msg "${NOFORMAT}\nFirewall restarted after changes"

# Install command line tools
[[ $(xcode-select -p 1>/dev/null; echo $?) == "2" ]] &&  xcode-select --install

# Install homebrew if not installed
msg "${PURPLE}\n=== Installing package management ==="
if ! command -v brew &> /dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install chezmoi and add dotfiles if chezmoi and dotfiles folder aren't present
msg "${PURPLE}\n=== Installing dotfiles ==="
if ! command -v chezmoi &> /dev/null && ! test -d ~/.local/share/chezmoi; then
  chezmoi init --apply --verbose https://github.com/otahontas/dotfiles.git
fi


# Install taps, apps and packages. Each step is performed if current state differs from
# dotfiles backup.
msg "${PURPLE}\n=== Installing packages ==="
pkg_dir="$(chezmoi source-path)/mac/packages"
if ! diff <(brew tap | grep -v "homebrew/") <(cat "$pkg_dir/taps.txt"); then
  while read -r tap; do 
    brew tap "$tap"
  done < "$pkg_dir/taps.txt"
fi

if ! diff <(brew leaves) <(cat "$pkg_dir/formulae.txt"); then
  while read -r formula; do 
    brew install "$formula"
  done < "formulae.txt"
fi

if ! diff <(brew list --cask) <(cat "$pkg_dir/casks.txt"); then
  while read -r cask; do 
    brew install --cask "$cask"
  done < "$pkg_dir/casks.txt"
fi

if ! diff <(mas list | sort) <(sort < "$pkg_dir/mas.txt"); then
  while read -r line; do 
    mas install "$(echo "$line" | cut -d' ' -f1)"
  done < "$pkg_dir/mas.txt"
fi

# Adding custom files to different places
msg "${PURPLE}\n=== Moving needed files to correct places ==="

test -f ~/Library/Keyboard\ Layouts/U.S.\ International\ wo\ dead\ keys.keylayout || cp "$script_dir/files/U.S. International wo dead keys.keylayout" ~/Library/Keyboard\ Layouts/

# Create needed folder
msg "${PURPLE}\n=== Creating folders ==="
test -d ~/Code || mkdir Code
