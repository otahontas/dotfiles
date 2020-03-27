#!/bin/sh
# Systemd doesn't know about ssh env variables set on .zlogin, so they need 
# to be set again here
unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
    export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi

# Run the script itself
notify-send "Pushing etckeeper repo to remote" "gpg-agent authentication possibly needed"
git --git-dir=/etc/.git push
exit_status=$?
if [[ $exit_status -ne 0 ]]; then
    exit 1;
fi
notify-send "Successfully pushed etckeeper repo to remote"
exit 0;
