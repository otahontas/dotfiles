#!/usr/bin/env bash

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
    msg "${RED}\nError happened while running installation script on line $line.${NOFORMAT}\nAfter you've fixed the error, you can safely re-run the script. It will skip parts that have been already performed."
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

setup_colors

# === Installation ===

msg "${PURPLE}\n=== Setting up networking ===${NOFORMAT}"

[[ $(scutil --get ComputerName) == "MacBook" ]] || sudo scutil --set ComputerName MacBook
[[ $(scutil --get LocalHostName) == "MacBook" ]] || sudo scutil --set LocalHostName MacBook


msg "${PURPLE}\n=== Setting up safety stuff ===${NOFORMAT}"

fdesetup status | grep -q "FileVault is On" || sudo fdesetup enable

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


msg "${PURPLE}\n=== Installing package management and chezmoi ===${NOFORMAT}"

[[ $(xcode-select -p 1>/dev/null; echo $?) == "2" ]] &&  xcode-select --install

if ! command -v brew &> /dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

/usr/local/bin/brew install chezmoi rcmdnk/file/brew-file

msg "${PURPLE}\n=== Installing dotfiles ===${NOFORMAT}"

if ! command -v chezmoi &> /dev/null && ! test -d ~/.local/share/chezmoi; then
  chezmoi init --apply --verbose https://github.com/otahontas/dotfiles.git
fi

msg "${PURPLE}\n=== Installing packages ===${NOFORMAT}"

env HOMEBREW_BREWFILE="$(chezmoi --source-path)/mac/packages/Brewfile" brew file install

msg "${PURPLE}\n=== Moving needed files to correct places ===${NOFORMAT}"

test -f ~/Library/Keyboard\ Layouts/U.S.\ International\ wo\ dead\ keys.keylayout || cp "$script_dir/files/U.S. International wo dead keys.keylayout" ~/Library/Keyboard\ Layouts/


msg "${PURPLE}\n=== Add some cool tweaks ===${NOFORMAT}"
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true
defaults write -g WebKitDeveloperExtras -bool YES

msg "${PURPLE}\n=== Creating folders ===${NOFORMAT}"
test -d ~/Code || mkdir Code

msg "${PURPLE}\n=== Setup some better finder options ===${NOFORMAT}"
defaults write com.apple.finder QuitMenuItem -bool true
defaults write com.apple.finder AppleShowAllFiles -boolean true;
defaults write com.apple.screencapture location ~

msg "${GREEN}\nOkay, quitting Finder ${NOFORMAT}"
killall Finder
osascript -e 'quit app "Finder"'

msg "${PURPLE}\n=== Disable Desktop ===${NOFORMAT}"
defaults write com.apple.finder CreateDesktop false
\rm -rf ~/Desktop
sudo chflags -h schg ~/Desktop
msg "${GREEN}Done disabling, remember to remove desktop from Finder sidebar${NOFORMAT}"
