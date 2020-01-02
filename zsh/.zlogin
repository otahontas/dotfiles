# Load sway on the start of a login shell
if [[ $(tty) = /dev/tty1 ]]; then
  exec sway
fi
