# Run sway on login
if [[ -z "${WAYLAND_DISPLAY}" ]] && [[ "${TTY}" = /dev/tty1 ]]; then
    exec sway
fi
