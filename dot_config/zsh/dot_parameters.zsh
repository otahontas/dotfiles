## Configurations for launching zsh with custom parameters

# 1) Zsh can be started interactively while running command with:
# "zsh -is eval 'command'", where -i means interactive and -s reads eval from
# stdin
if [[ $1 == eval ]]; then
    "$@"
    set --
fi
