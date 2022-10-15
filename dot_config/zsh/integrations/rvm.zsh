export GEM_HOME="$XDG_CACHE_HOME/gem"
[[ $PATH != *"$XDG_CACHE_HOME/rvm/bin"* ]] && export PATH="$XDG_CACHE_HOME/rvm/bin:$PATH"
[[ $PATH != *"$XDG_CACHE_HOME/gem/bin"* ]] && export PATH="$XDG_CACHE_HOME/gem/bin:$PATH"

source "$XDG_CACHE_HOME/rvm/scripts/rvm"
