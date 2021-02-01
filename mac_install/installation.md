# Notes

- Add list of brew and brew cask applications from another computer with
  1. `brew list --cask > cask_packages` and `brew list --formula > brew_packages`
  2. Install with `brew install --cask < cask_packages` and `brew install < brew_packages`
- Add custom keyboard (move file in this folder to `/Library/Keyboard\ Layouts`
- Fix that path_helper doesn't load on every tmux launch by changing lines in
  `etc/zprofile` to

```bash
if [ -x /usr/libexec/path_helper ]; then
  if [ -z "$TMUX" ]; then
    eval `/usr/libexec/path_helper -s`
  fi
fi
```
