export GEM_HOME="$XDG_CACHE_HOME/gem"
[[ $PATH != *"$XDG_CACHE_HOME/rvm/bin"* ]] && export PATH="$PATH:$XDG_CACHE_HOME/rvm/bin"
[[ $PATH != *"$XDG_CACHE_HOME/gem/bin"* ]] && export PATH="$PATH:$XDG_CACHE_HOME/gem/bin"
