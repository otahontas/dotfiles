# Avoid nvim nesting
if [ -n "$NVIM_LISTEN_ADDRESS" ]; then
    if [ -x "$(command -v nvr)" ]; then
        alias nvim="env TERM=wezterm nvr -cc split --remote-wait +'set bufhidden=wipe'"
    else
        alias nvim="echo 'Nesting instances not allowed!'"
    fi
fi

# Nvim needs to know wezterm TERM is set to enable various font styles
alias nvim="env TERM=wezterm command nvim"

# Override vim & vi
alias vim=nvim
alias vi=vi
