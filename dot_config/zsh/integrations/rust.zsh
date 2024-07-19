# Setup cargo environment variables and load cargo binaries into path
export RUSTUP_HOME=$XDG_CACHE_HOME/rustup
export CARGO_HOME=$XDG_CACHE_HOME/cargo
source "$CARGO_HOME/env"

# Set up interactive repl
alias rust-repl="evcxr"
