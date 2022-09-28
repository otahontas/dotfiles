export GOPATH=$XDG_CACHE_HOME/go
[[ $PATH != *"$GOPATH"* ]] && export PATH="$GOPATH/bin:$PATH"
