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
export FZF_DEFAULT_COMMAND='fd -H --follow'
export FZF_ALT_C_COMMAND='fd -H --follow --type directory'
export FZF_CTRL_T_COMMAND='fd -H --follow --type file'
source /usr/share/fzf/completion.zsh
source /usr/share/fzf/key-bindings.zsh

# Set correct tty for GPG
export GPG_TTY=$(tty)
gpg-connect-agent updatestartuptty /bye >/dev/null

# Load pyenv if not loaded
[[ $PATH != *"$(pyenv root)/shims"* ]] && eval "$(pyenv init -)"

# Load poetry to path if not loaded
[[ $PATH != *"$HOME/.poetry/bin"* ]] && export PATH=$HOME/.poetry/bin:$PATH

# Load nvm if not loaded
[[ -z "$NVM_DIR" ]] && export NVM_DIR=$XDG_CACHE_HOME/nvm
source /usr/share/nvm/nvm.sh
source /usr/share/nvm/bash_completion

# Avoid nvim nesting
if [ -n "$NVIM_LISTEN_ADDRESS" ]; then
    if [ -x "$(command -v nvr)" ]; then
        alias nvim=nvr
    fi
fi

