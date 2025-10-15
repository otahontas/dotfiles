# === zsh ===
HISTFILE=$XDG_DATA_HOME/zsh/histfile
HISTSIZE=10000
SAVEHIST=$HISTSIZE
setopt sharehistory
setopt incappendhistory
setopt histexpiredupsfirst
setopt histignoredups
setopt histfindnodups
setopt histreduceblanks
# Allow cd'ing without writing cd
setopt autocd
setopt extendedglob
# Set vi-mode to launch immediately
export KEYTIMEOUT=1
# Disable command to replay last command
disable r
# Set up completion options
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion::complete:*' gain-privileges 1
zstyle :compinstall filename '$ZDOTDIR/.zshrc'
autoload -Uz compinit
setopt correct
setopt correctall
setopt no_list_ambiguous
setopt globdots

# Load completions lazily (not on every startup)
() {
  if [[ $# -gt 0 ]]; then
    autoload -Uz compinit
    compinit
    autoload bashcompinit && bashcompinit
  else
    compinit -C
  fi
} ${ZDOTDIR}/.zcompdump(N.mh+24)

# === Source modular configs ===
source ${ZDOTDIR}/env.zsh
source ${ZDOTDIR}/aliases.zsh
source ${ZDOTDIR}/functions.zsh

# === fzf ===
# Add completions and keybindings
source <(fzf --zsh)

# === Antidote (plugins) ===
# Lazy-load antidote from its functions directory.
fpath+="/opt/homebrew/opt/antidote/share/antidote/functions"
autoload -Uz antidote
# From: https://antidote.sh
# Set the root name of the plugins files (.txt and .zsh) antidote will use.
zsh_plugins=${ZDOTDIR:-~}/.zsh_plugins
# Ensure the .zsh_plugins.txt file exists so you can add plugins.
[[ -f ${zsh_plugins}.txt ]] || touch ${zsh_plugins}.txt
# Lazy-load antidote from its functions directory.
fpath=(/path/to/antidote/functions $fpath)
autoload -Uz antidote
# Generate a new static file whenever .zsh_plugins.txt is updated.
if [[ ! ${zsh_plugins}.zsh -nt ${zsh_plugins}.txt ]]; then
  antidote bundle <${zsh_plugins}.txt >|${zsh_plugins}.zsh
fi
# Source your static plugins file.
source ${zsh_plugins}.zsh


# === zoxide ===
eval "$(zoxide init zsh)"

# === bun ===
[ -s "/Users/otahontas/.bun/_bun" ] && source "/Users/otahontas/.bun/_bun"

# === safe-chain ===
source ~/.safe-chain/scripts/init-posix.sh # Safe-chain Zsh initialization script

# === Prompt ===
PS1='%F{blue}%~ %(?.%F{green}.%F{red})%#%f '

# Run the check when shell starts (but not for non-interactive shells)
if [[ -o interactive ]]; then
    check_update_packages
fi
