#!/bin/sh
echo "// Symlinking .pam_environment to HOME"
dest=$HOME/.pam_environment
[[ -e $dest ]] || ln -s $HOME/.config/pam_environment $dest
echo "Done"
