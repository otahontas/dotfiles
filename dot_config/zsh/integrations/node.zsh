# Use xdg for node stuff
export NODE_REPL_HISTORY=$XDG_DATA_HOME/node_repl_history
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc

# Node package manager scripts with fzf for yarn, npm, and pnpm
function run_packagejson_script() {
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
  run_packagejson_script "yarn"
}

function npms() {
  run_packagejson_script "npm"
}

function pnpms() {
  run_packagejson_script "pnpm"
}
