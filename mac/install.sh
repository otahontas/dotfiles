#!/usr/bin/env bash

# === 1. Settings ===

# Dock
defaults write com.apple.dock "tilesize" -int "15"
defaults write com.apple.dock "autohide" -bool "true"

# Screenshots
defaults write com.apple.screencapture location ~

# Finder
# TODO: read flags before setting
test -d ~/Desktop && sudo rm -rf ~/Desktop
sudo chflags -h schg ~/Desktop
defaults write com.apple.finder "QuitMenuItem" -bool true
defaults write com.apple.finder "AppleShowAllFiles" -boolean true;
defaults write com.apple.finder "CreateDesktop" false

# Mission control
defaults write com.apple.dock "mru-spaces" -bool "false"

# Restart dock & finder
killall Dock
killall Finder
osascript -e 'quit app "Finder"'

# Networking
[[ $(scutil --get ComputerName) == "MacBook" ]] || sudo scutil --set ComputerName MacBook
[[ $(scutil --get LocalHostName) == "MacBook" ]] || sudo scutil --set LocalHostName MacBook
firewall_changed="false"
if ! /usr/libexec/ApplicationFirewall/socketfilterfw --getglobalstate | grep -q "Firewall is enabled"; then
  sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on
  firewall_changed=true
fi
if ! /usr/libexec/ApplicationFirewall/socketfilterfw --getloggingmode | grep -q "Log mode is on"; then
  sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setloggingmode on
  firewall_changed=true
fi
if ! /usr/libexec/ApplicationFirewall/socketfilterfw --getstealthmode | grep -q "Stealth mode enabled"; then
  sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setstealthmode on
  firewall_changed=true
fi
[[ "$firewall_changed" == "true" ]] && sudo pkill -HUP socketfilterfw

# Safety
fdesetup status | grep -q "FileVault is On" || sudo fdesetup enable

# Dev stuff
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true
defaults write -g WebKitDeveloperExtras -bool YES
test -d ~/Code || mkdir Code

# Keyboard stuff
test -f ~/Library/Keyboard\ Layouts/U.S.\ International\ wo\ dead\ keys.keylayout || curl https://raw.githubusercontent.com/otahontas/dotfiles/main/mac/files/U.S.%20International%20wo%20dead%20keys.keylayout --output ~/Library/Keyboard\ Layouts/U.S.\ International\ wo\ dead\ keys.keylayout

# == 2. Install packages ===

# xcode & brew
[[ $(xcode-select -p 1>/dev/null; echo $?) == "2" ]] &&  xcode-select --install
if ! command -v brew &> /dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# TODO:fi
# Install packages
# Write a list of stuff that I toggle, but aren't togglable without the GUI (i.e.
# finalize manual
# stuff)

# === n. Manual stuff ===
echo ""
echo "=== Stuff to do manually ==="
echo "- Change the keyboard layout to U.S. International wo dead keys"
