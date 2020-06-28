# Config file for non-zsh -settings, such as completions, other program env
# variables

# Load s completions
source /usr/share/bash-completion/completions/s

# Add SSH completions from ~/.ssh/config
h=()
if [[ -r ~/.ssh/config ]]; then
  h=($h ${${${(@M)${(f)"$(cat ~/.ssh/config)"}:#Host *}#Host }:#*[*?]*})
fi

if [[ $#h -gt 0 ]]; then
  zstyle ':completion:*:ssh:*' hosts $h
  zstyle ':completion:*:slogin:*' hosts $h
fi

# Set FZF defaults and completions
export FZF_DEFAULT_OPTS='--height 50% --layout=reverse'
export FZF_DEFAULT_COMMAND='fd -H --follow --exclude .git'
export FZF_ALT_C_COMMAND='fd -H --follow --exclude .git -t d'
export FZF_CTRL_T_COMMAND='fd -H --follow --exclude .git -t f'
source /usr/share/fzf/completion.zsh
source /usr/share/fzf/key-bindings.zsh

# Set correct tty for GPG
export GPG_TTY=$(tty)
gpg-connect-agent updatestartuptty /bye >/dev/null

# Load pyenv
eval "$(pyenv init -)"

# Load nvm 
source /usr/share/nvm/init-nvm.sh

# Avoid nvim nesting
if [ -n "$NVIM_LISTEN_ADDRESS" ]; then
    if [ -x "$(command -v nvr)" ]; then
        alias nvim=nvr
    else
        alias nvim='echo "No nesting!"'
    fi
    alias vim=nvim
    alias vi=nvim
fi
