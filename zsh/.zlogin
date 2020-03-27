# Set SSH to use gpg-agent instead of ssh-agent
unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
    export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi

# Run sway on login
if [[ -z "${WAYLAND_DISPLAY}" ]] && [[ "${TTY}" = /dev/tty1 ]]; then
    exec sway
fi
