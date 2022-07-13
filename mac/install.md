# Macos install

Notes from 2022

## Installation

## System settings

Install keyboard layout:

```sh
test -f ~/Library/Keyboard\ Layouts/U.S.\ International\ wo\ dead\ keys.keylayout || curl https://raw.githubusercontent.com/otahontas/dotfiles/main/mac/files/U.S.%20International%20wo%20dead%20keys.keylayout --output ~/Library/Keyboard\ Layouts/U.S.\ International\ wo\ dead\ keys.keylayout
```

Go through settings

- Apple ID + check iCloud settings
- Desktop & screen saver:
  - Turn hot corners off
  - Disable screensaver
- Dock & Menu bar:
  - Dock size small
  - Autohide dock
  - Autohide menubar
- Mission control:
  - Don’t automatically rearrange
  - Displays have separate spaces
  - Keyboard shortcuts off
- Spotlight:
  - Only applications
- Language & region:
  - Correct region, calendar & format
- Security & privacy
  - FireVault
  - Firewall, turn all options on, but don’t block all incoming
  - Privacy: disable ad personalisation + analytics
- Sound:
  - Sound effect: Alert volume off, all options off
- Keyboard:
  - Modifier keys: Swap command & option, caps lock to esc
  - Input sources: Select U.S int no dead keys, don’t show stuff in menu bar
- Sharing:
  - Turn everything off
  - Set Computer Name to “MacBook”
- Time machine:
  - Turn on
- Battery
  - Never turn the display off (battery & power adapter)
- Date & time: Set correct time zone

## Finder

Create code folder:

```sh
test -d ~/Code || mkdir Code
```

Add some hidden finder features:

```sh
defaults write com.apple.finder "QuitMenuItem" -bool true
defaults write com.apple.finder "AppleShowAllFiles" -boolean true;
```

Remove desktop:

```bash
test -d ~/Desktop && sudo rm -rf ~/Desktop
sudo chflags -h schg ~/Desktop
defaults write com.apple.finder "CreateDesktop" false
killall Finder
osascript -e 'quit app "Finder"'
```

## Packages

Install xcode, brew, rosetta:

```sh
[[ $(xcode-select -p 1>/dev/null; echo $?) == "2" ]] &&  xcode-select --install
if ! command -v brew &> /dev/null; then
  /bin/bash -c "$(curl -fsSL <https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh>)"
fi
sudo softwareupdate --install-rosetta
```

Install packages:

```sh
curl https://raw.githubusercontent.com/otahontas/dotfiles/main/mac/packages/Brewfile | brew bundle --file=-
```
