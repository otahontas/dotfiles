# Load volta on command (useful for local .zsh files)
function load_volta() {
    export VOLTA_HOME="$HOME/.volta"
    export PATH="$VOLTA_HOME/bin:$PATH"
    export VOLTA_FEATURE_PNPM=1
}
