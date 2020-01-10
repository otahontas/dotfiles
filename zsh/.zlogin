# Run sway on login
# Disable pinenty-tty for all programs and let .zshrc set it if needed
if [[ -z $WAYLAND_DISPLAY ]] && [[ "$TTY" = /dev/tty1 ]]; then
    unset PINENTRY_USER_DATA
    exec sway
fi
