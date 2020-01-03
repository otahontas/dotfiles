# Source aliases and custom functions
source $ZDOTDIR/.zsh_aliases
source $ZDOTDIR/.zsh_functions

# Load plugins staticly with antibody
# Note: Run 'antibody bundle < .zsh_plugins.txt > .zsh_plugins.sh' after 
# updating .zsh_plugins.txt -list
source $ZDOTDIR/.zsh_plugins.sh

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
autoload -Uz compinit && compinit -d $XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION
autoload bashcompinit && bashcompinit
setopt correct
setopt correctall

# Set vi-mode to launch immidiately and set up binding for history search
export KEYTIMEOUT=1
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# Load enviromental variables and settings only to be used with interactive shell
source /usr/share/LS_COLORS/dircolors.sh
source $ZDOTDIR/.fzf.zsh

# Load prompt
[[ ! -f $ZDOTDIR/.p10k.zsh ]] || source $ZDOTDIR/.p10k.zsh
