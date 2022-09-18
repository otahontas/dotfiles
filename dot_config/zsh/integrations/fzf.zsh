# Add completions and keybindings
[[ "$PATH" != *"/usr/local/opt/fzf/bin"* ]] && export PATH=/usr/local/opt/fzf/bin:$PATH
[[ $- == *i* ]] && source "/usr/local/opt/fzf/shell/completion.zsh" 2> /dev/null
source "/usr/local/opt/fzf/shell/key-bindings.zsh"
bindkey "©" fzf-cd-widget

# Setup defaults
export FZF_DEFAULT_OPTS="--height 50% --layout=reverse
--color=fg:#4b505b,bg:#fafafa,hl:#5079be
--color=fg+:#4b505b,bg+:#fafafa,hl+:#3a8b84
--color=info:#88909f,prompt:#d05858,pointer:#b05ccc
--color=marker:#608e32,spinner:#d05858,header:#3a8b84"
# Always show hidden, follow symlinks, and use preview window
export FZF_DEFAULT_COMMAND="fd --hidden --follow --strip-cwd-prefix"
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND --type directory"
export FZF_ALT_C_OPTS="--preview 'exa -la --color=always {}' --select-1 --exit-0"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND --type file"
export FZF_CTRL_T_OPTS="--preview 'bat --style=numbers --color=always --line-range :500 {}' --select-1 --exit-0"

# Setup fzf tab game
# # disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# preview directory's content with exa when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
# switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'
# Change detault color
zstyle ':fzf-tab:*' default-color $'\033[38;5;19m'
