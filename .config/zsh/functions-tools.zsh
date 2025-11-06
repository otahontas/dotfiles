# === Brew ===
# Wrapper for brew to execute brewfile dumping on certain brew commands
function brew () {
    local dump_commands=("install" "uninstall" "tap" "untap" "upgrade" "update")
    local main_command="${1}"
    local brewfile_path="$XDG_DATA_HOME/brew/brewfile"
    /opt/homebrew/bin/brew ${@}
    for command in "${dump_commands[@]}"; do
        [[ "${command}" == "${main_command}" ]] && /opt/homebrew/bin/brew bundle dump --file="$brewfile_path" --force
    done
}

# === Node ===
# Node package manager scripts with fzf for yarn, npm, and pnpm
function _run_packagejson_script() {
  local package_manager="$1"
  if [ ! -f package.json ]; then
    echo "package.json not found" >&2
  else
    local command=$(jq '.scripts | keys[]' package.json -r | tr -d '"' |
    fzf --reverse \
      --preview-window=:wrap \
      --preview "jq '.scripts.\"{}\"' package.json -r | tr -d '\"' | sed 's/^[[:blank:]]*//'")
    if [ -n "$command" ]; then
      eval "$package_manager run $command"
    fi
  fi
}
function yarns() {
  _run_packagejson_script "yarn"
}
function npms() {
  _run_packagejson_script "npm"
}
function pnpms() {
  _run_packagejson_script "pnpm"
}

# === yazi ===
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}
