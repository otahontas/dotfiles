# Set correct tty for GPG
export GPG_TTY=$(tty)
gpg-connect-agent updatestartuptty /bye >/dev/null
