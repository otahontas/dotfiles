# Alias cat to bat
alias cat="bat"

# Set bat as manpager
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# Set global alias for help flags to use bat
alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'
