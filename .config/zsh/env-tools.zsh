# === Bat ===
# Note: if bat colors are not working, run `bat cache --build` to rebuild cache
export BAT_THEME="Catppuccin Mocha"
# Set bat as manpager
export MANPAGER="sh -c 'awk '\''{ gsub(/\x1B\[[0-9;]*m/, \"\", \$0); gsub(/.\x08/, \"\", \$0); print }'\'' | bat -p -lman'"

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

# Setup fzf-tab completion styles
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# preview directory's content with eza when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
# switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'

# === GPG ===
# Set correct tty for GPG
export GPG_TTY="$(tty)"

# === Git Hooks ===
# Disable husky - use own hooks from ~/.config/git/template/hooks
export HUSKY=0

# === Less ===
# Use xdg based history file
export LESSHISTFILE="$XDG_DATA_HOME/less_history"

# === llm ===
# Bind Alt-\ to LLM command completion
bindkey '\e\\' __llm_cmdcomp
__llm_cmdcomp() {
  local old_cmd=$BUFFER
  local cursor_pos=$CURSOR
  echo # Start the program on a blank line
  local result=$(llm cmdcomp "$old_cmd")
  if [ $? -eq 0 ] && [ ! -z "$result" ]; then
    BUFFER=$result
  else
    BUFFER=$old_cmd
  fi
  zle reset-prompt
}
zle -N __llm_cmdcomp

# === LS colors ===
export LS_COLORS=$(vivid generate catppuccin-mocha)

# === Node ===
export NODE_REPL_HISTORY="$XDG_DATA_HOME/node_repl_history"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"

# === Prompt ===
export SHOW_AWS_PROMPT="false"

# === SQLite ===
# Use xdg based history file
export SQLITE_HISTORY="$XDG_DATA_HOME/sqlite_history"

# === SSH ===
# Use 1password as ssh agent
export SSH_AUTH_SOCK="~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock"

# === wget ===
export WGETRC=$XDG_CONFIG_HOME/wget/wgetrc
