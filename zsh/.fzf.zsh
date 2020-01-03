# Set FZF defaults
export FZF_DEFAULT_OPTS='--height 50% --layout=reverse'
export FZF_DEFAULT_COMMAND='fd -H'
export FZF_ALT_C_COMMAND='fd -H -t d'
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
