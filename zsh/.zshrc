# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Source aliases and custom functions
source $ZDOTDIR/.zsh_aliases
source $ZDOTDIR/.zsh_functions

# Create big enough history file, disable duplicates and allow different zsh
# shells to share history all the time (e.g. don't wait until shell is closed)
HISTFILE=$XDG_DATA_HOME/zsh/histfile
HISTSIZE=2500
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

# Set up completions, compinit file folder and corrections
zstyle :compinstall filename '$ZDOTDIR/.zshrc'
zstyle ':completion:*' menu select
autoload -Uz compinit && compinit
autoload bashcompinit && bashcompinit
source /home/otahontas/.config/zsh/.completions.zsh
setopt correct
setopt correctall

# Load plugins
source <(antibody init)
antibody bundle < $ZDOTDIR/.zsh_plugins.txt

# Set vi-mode to launch immidiately and set up binding for history search
export KEYTIMEOUT=1
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# Load enviromental variables and settings only to be used with interactive shell
source /usr/share/LS_COLORS/dircolors.sh
source $ZDOTDIR/.fzf.zsh

if [[ ! -z "${WAYLAND_DISPLAY}" ]]; then
    export PINENTRY_USER_DATA=USE_TTY=1
fi

# Load prompt
[[ ! -f $ZDOTDIR/.p10k.zsh ]] || source $ZDOTDIR/.p10k.zsh
