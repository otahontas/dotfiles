# === Local bin ===
export PATH="$HOME/.local/bin:$PATH"

# === Brew ===
# This is a bit modified output of `/opt/homebrew/bin/brew shellenv`
# it's here to avoid running `brew` on every shell start
export HOMEBREW_PREFIX="/opt/homebrew"
export HOMEBREW_CELLAR="/opt/homebrew/Cellar"
export HOMEBREW_REPOSITORY="/opt/homebrew"
fpath+="/opt/homebrew/share/zsh/site-functions"
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
export INFOPATH="/opt/homebrew/share/info:$INFOPATH";

# === Docker ===
fpath=(/Users/otahontas/.docker/completions $fpath)

# === Go ===
# Setup gopath and add it to the path
export GOPATH="$XDG_CACHE_HOME/go"
export PATH="$GOPATH/bin:$PATH"

# === Grep ===
# Add gnu grep to path
export PATH="$(brew --prefix)/opt/grep/libexec/gnubin:$PATH"

# === Rust ===
# Setup correct env vars
export RUSTUP_HOME="$XDG_CACHE_HOME/rustup"
export CARGO_HOME="$XDG_CACHE_HOME/cargo"
# Add rust binaries to path
export PATH="/opt/homebrew/opt/rustup/bin:$PATH"

# === Volta ===
export VOLTA_HOME="$XDG_CACHE_HOME/volta"
export PATH="$VOLTA_HOME/bin:$PATH"
export VOLTA_FEATURE_PNPM=1
