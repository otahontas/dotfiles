# Avoid nvim nesting
if [ -n "$NVIM_LISTEN_ADDRESS" ]; then
    if [ -x "$(command -v nvr)" ]; then
        alias nvim="nvr -cc split --remote-wait +'set bufhidden=wipe'"
        alias vim="nvr -cc split --remote-wait +'set bufhidden=wipe'"
        alias vi="nvr -cc split --remote-wait +'set bufhidden=wipe'"
    else 
        alias nvim="echo 'No nesting!'"
        alias vim="echo 'No nesting!'"
        alias vi="echo 'No nesting!'"
    fi
fi
