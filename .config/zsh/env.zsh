# === Local bin ===
export PATH="$HOME/.local/bin:$PATH"

# === iCloud ===
export ICLOUD="$HOME/Library/Mobile Documents"
export ICLOUD_DRIVE="$ICLOUD/com~apple~CloudDocs"
export OBSIDIAN_NOTES="$ICLOUD/iCloud~md~obsidian/Documents/Notes"

# === Brew ===
# This is a bit modified output of `/opt/homebrew/bin/brew shellenv`
# it's here to avoid running `brew` on every shell start
export HOMEBREW_PREFIX="/opt/homebrew"
export HOMEBREW_CELLAR="/opt/homebrew/Cellar"
export HOMEBREW_REPOSITORY="/opt/homebrew"
fpath+="/opt/homebrew/share/zsh/site-functions"
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
export INFOPATH="/opt/homebrew/share/info:$INFOPATH";

# === Bat ===
# Note: if bat colors are not working, run `bat cache --build` to rebuild cache
export BAT_THEME="Catppuccin Mocha"
# Set bat as manpager
export MANPAGER="sh -c 'awk '\''{ gsub(/\x1B\[[0-9;]*m/, \"\", \$0); gsub(/.\x08/, \"\", \$0); print }'\'' | bat -p -lman'"

# === Docker ===
fpath=(/Users/otahontas/.docker/completions $fpath)

# === Eza ===
export EZA_ICONS_AUTO=1

# === fzf ===
# Setup defaults
# Colors from: https://github.com/catppuccin/fzf?tab=readme-ov-file#usage
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1E1E2E,spinner:#F5E0DC,hl:#F38BA8 \
--color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC \
--color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 \
--color=selected-bg:#45475A \
--color=border:#6C7086,label:#CDD6F4 \
--height 50% \
--layout=reverse"
# Always show hidden, follow symlinks, and use preview window
export FZF_DEFAULT_COMMAND="fd --hidden --follow --strip-cwd-prefix"
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND --type directory"
export FZF_ALT_C_OPTS="--preview 'eza -la --color=always {}' --select-1 --exit-0"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND --type file"
export FZF_CTRL_T_OPTS="--preview 'bat --style=numbers --color=always --line-range :500 {}' --select-1 --exit-0"

# === Go ===
# Setup gopath and add it to the path
export GOPATH="$XDG_CACHE_HOME/go"
export PATH="$GOPATH/bin:$PATH"

# === GPG ===
# Set correct tty for GPG
export GPG_TTY="$(tty)"

# === Grep ===
# Add gnu grep to path
export PATH="$(brew --prefix)/opt/grep/libexec/gnubin:$PATH"

# === Less ===
# Use xdg based history file
export LESgHISTFILE="$XDG_DATA_HOME/less_history"

# === Node ===
export NODE_REPL_HISTORY="$XDG_DATA_HOME/node_repl_history"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"

# === Rust ===
# Setup correct env vars
export RUSTUP_HOME="$XDG_CACHE_HOME/rustup"
export CARGO_HOME="$XDG_CACHE_HOME/cargo"
# Add rust binaries to path
export PATH="/opt/homebrew/opt/rustup/bin:$PATH"

# === SQLite ===
# Use xdg based history file
export SQLITE_HISTORY="$XDG_DATA_HOME/sqlite_history"

# === SSH ===
# Use 1password as ssh agent
export SSH_AUTH_SOCK="~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock"

# === Volta ===
export VOLTA_HOME="$XDG_CACHE_HOME/volta"
export PATH="$VOLTA_HOME/bin:$PATH"
export VOLTA_FEATURE_PNPM=1

# === Prompt ===
export SHOW_AWS_PROMPT="false"

# === LS colors (todo make faster) === 
export LS_COLORS=$(vivid generate catppuccin-mocha)

# === wget ===
export WGETRC=$XDG_CONFIG_HOME/wget/wgetrc

# === wezget ===
alias imgcat="wezterm imgcat"
alias ssh="wezterm ssh"
