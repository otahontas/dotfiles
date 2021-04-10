# Avoid nvim nesting
if [ -n "$NVIM_LISTEN_ADDRESS" ]; then
    if [ -x "$(command -v nvr)" ]; then
        alias nvim="nvr -cc split --remote-wait +'set bufhidden=wipe'"
        alias vim=nvim
        alias vi=vi
    else 
        alias nvim="echo 'Nesting instances not allowed!'"
        alias vim=nvim
        alias vi=vi
    fi
fi
