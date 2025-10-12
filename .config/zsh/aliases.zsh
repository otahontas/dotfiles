# === pinentry ===
alias pinentry='pinentry-mac'

# Set some better defaults for default apps
alias grep="grep --color=auto"
alias info="info --vi-keys"

# === Bat ===
# Alias cat to bat
alias cat="bat"
# Set global alias for help flags to use bat
alias -g -- -h='-h 2>&1 | bat --language=help --style=plain'
alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'

# Backtracking
alias ...="cd ../.."
alias ....="cd ../../.."

# Don't autocorrect some commands
alias cd="nocorrect cd"
alias cp='nocorrect cp '
alias mv='nocorrect mv '
alias mkdir='nocorrect mkdir '

# === Eza ===
# Alias ls to eza
alias ls="eza"
# Add some useful ls aliases
alias la="eza -la"
alias ll="eza -l"
alias lr="eza -Rl"

# === Git ===
alias gsw="git sw"

# === iCloud ===
alias drive="cd '$ICLOUD_DRIVE'"
alias obs="cd '$OBSIDIAN_NOTES'"
alias todo="nvim '$ICLOUD_DRIVE/todo.txt'"
alias todo-plan "drive && claude -c"

# === npq ===
alias npm='npq-hero'
alias pnpm="NPQ_PKG_MGR=pnpm npq-hero"
alias yarn="NPQ_PKG_MGR=yarn npq-hero"

# weekly stuff
alias week="date +%U"
alias today='date +%F'

# dotfiles
alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
