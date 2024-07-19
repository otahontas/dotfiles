# Setup gopath and add it to the path
export GOPATH=$XDG_CACHE_HOME/go
[[ $PATH != *"$GOPATH"* ]] && export PATH="$GOPATH/bin:$PATH"
