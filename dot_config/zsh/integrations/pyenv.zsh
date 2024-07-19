# use xdg for pyenv
export PYENV_ROOT=$XDG_CACHE_HOME/pyenv

# Set pyenv root to path
[[ $PATH != *"$PYENV_ROOT/bin"* ]] && export PATH="$PYENV_ROOT/bin:$PATH"

# Load pyenv executable from path
eval "$(pyenv init --path)"

# Load pyenv
eval "$(pyenv init -)"
