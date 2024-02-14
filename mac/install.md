# Macos install

Notes from 2022 Mojave install

## Wizard

Set up region, languages, input source, dictation, wifi, Apple ID, icloud keychain sync, screen time, no analytics, no siri, firevault, touch id, no pay, light theme

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
  - Shortcuts:
    - Copy picture of selected area to clipboard: hyper-P
    - Spotlight: Shift-Cmd-Space
    - Turn everything else off
  - Input sources: Select U.S int no dead keys, don’t show stuff in menu bar
- Sharing:
  - Turn everything off
  - Change computer Name to not have my name
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

Don't write .DS_STORE files on network or usb

```
defaults write com.apple.desktopservices DSDontWriteNetworkStores true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
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

Install xcode, brew, rosetta (if needed):

```sh
[[ $(xcode-select -p 1>/dev/null; echo $?) == "2" ]] &&  xcode-select --install
if ! command -v brew &> /dev/null; then
  /bin/bash -c "$(curl -fsSL <https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh>)"
fi
sudo softwareupdate --install-rosetta
```

Install needed packages by using [Brewfile from packages folder](https://github.com/otahontas/dotfiles/tree/main/mac/packages) as a base:

```sh
vim Brewfile
# copypaste & edit
brew bundle --file=Brewfile
```
