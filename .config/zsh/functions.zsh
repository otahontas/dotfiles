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

# === fzf ===
# Setup fzf-tab
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# preview directory's content with eza when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
# switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'

# === llm ===
# Bind Alt-\ to LLM command completion
bindkey '\e\\' __llm_cmdcomp
__llm_cmdcomp() {
  local old_cmd=$BUFFER
  local cursor_pos=$CURSOR
  echo # Start the program on a blank line
  local result=$(llm cmdcomp "$old_cmd")
  if [ $? -eq 0 ] && [ ! -z "$result" ]; then
    BUFFER=$result
  else
    BUFFER=$old_cmd
  fi
  zle reset-prompt
}
zle -N __llm_cmdcomp

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

# === Custom functions ===
function listening() {
    if [ $# -eq 0 ]; then
        sudo lsof -iTCP -sTCP:LISTEN -n -P
    elif [ $# -eq 1 ]; then
        sudo lsof -iTCP -sTCP:LISTEN -n -P | grep -i --color $1
    else
        echo "Usage: listening [pattern]"
    fi
}

function find-and-prune() {
    find . -name $1 -prune | xargs \rm -rf
}

# Auto-prompt for update_packages script
function check-update-packages() {
    local timestamp_file="$XDG_DATA_HOME/update_packages_timestamp"
    local current_time=$(date +%s)
    local last_run=0

    # Read last run timestamp if file exists
    if [[ -f "$timestamp_file" ]]; then
        last_run=$(cat "$timestamp_file" 2>/dev/null || echo 0)
    fi

    # Check if 24 hours (86400 seconds) have passed
    local time_diff=$((current_time - last_run))
    if [[ $time_diff -ge 86400 ]]; then
        echo -n "Update packages? It's been $(($time_diff / 3600)) hours since last run. [y/N]: "
        read -r response

        case "$response" in
            [yY]|[yY][eE][sS])
                update-packages
                ;;
            *)
                echo "$current_time" > "$timestamp_file"
                ;;
        esac
    fi
}

# create system update function
function update-packages() {
  local LOG_FILE="${XDG_DATA_HOME}/system_update.log"
  local timestamp_file="$XDG_DATA_HOME/update_packages_timestamp"
  # `tee -a` appends to the log file while also printing to standard output.
  # `2>&1` redirects stderr to stdout, so both are captured.
  {
    echo "======================================================================"
    echo "Starting packages update at: $(date -u +"%Y-%m-%dT%H:%M:%SZ") (UTC)"
    echo "======================================================================"
    echo "\n🍺 Updating Homebrew formulas and casks..."
    if command -v brew &> /dev/null; then
      brew update
      brew upgrade --fetch-HEAD
      brew autoremove
      brew cleanup
    else
      echo "  Skipping: Homebrew (brew) not found."
    fi
    echo "\n💉 Updating antidote plugins..."
    if command -v antidote &> /dev/null; then
      antidote update
    else
      echo "  Skipping: antidote not found."
    fi
    echo "\n🐍 Updating volta tools..."
    if command -v volta &> /dev/null; then
        volta list --format plain | while IFS= read -r line; do
            if [[ $line =~ "^runtime " ]]; then
                # Handle runtime (node)
                echo "Updating node to LTS..."
                volta install node@lts
            elif [[ $line =~ "^package-manager " ]]; then
                # Handle package managers
                tool=$(echo "$line" | awk '{print $2}' | sed 's/@[^/]*$//')
                echo "Updating $tool..."
                volta install "$tool@latest"
            elif [[ $line =~ "^package " ]]; then
                # Handle global packages
                package=$(echo "$line" | awk '{print $2}' | sed 's/@[^/]*$//')
                [[ -n "$package" ]] || { echo "Error: empty package name from line: $line"; exit 1; }
                echo "Updating $package..."
                volta install "$package@latest"
            fi
        done
    else
      echo "  Skipping: volta not found."
    fi
    echo "\nnvim Updating Neovim plugins..."
    if command -v nvim &> /dev/null; then
        nvim +"lua vim.pack.update({}, {force=true})" +qa
    else
      echo "  Skipping: Neovim (nvim) not found."
    fi
    echo "======================================================================"
    echo "Finished packages update at: $(date -u +"%Y-%m-%dT%H:%M:%SZ") (UTC)"
    echo "======================================================================"
  } 2>&1 | tee -a "$LOG_FILE"
  # Update timestamp after successful completion
  echo "$(date +%s)" > "$timestamp_file"
  # Final confirmation message (this part is not logged)
  echo "✅ Packages update complete. Full log appended to: $LOG_FILE"
}

# Create folder and cd to it
function mcd() {
    mkdir $1 && cd $1
}

# Cd to folder and list content
function cl() {
    cd $1 && ls .
}

# Cleanup cache
function cache_cleanup() {
    read \?"This will cleanup cache older than 6 months. Are you sure (y/n)? "
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        find ~/.cache/ -depth -type f -atime +182 -delete
    fi
}
# Print terminal color palette
function palette() {
    local -a colors
    for i in {000..255}; do
        colors+=("%F{$i}$i%f")
    done
    print -cP $colors
}

# Print terminal color code formatted
# Usage: printcolor COLOR_CODE
function printcolor() {
    local color="%F{$1}"
    echo -E ${(qqqq)${(%)color}}
}

function listening() {
    if [ $# -eq 0 ]; then
        sudo lsof -iTCP -sTCP:LISTEN -n -P
    elif [ $# -eq 1 ]; then
        sudo lsof -iTCP -sTCP:LISTEN -n -P | grep -i --color $1
    else
        echo "Usage: listening [pattern]"
    fi
}

function myip() {
    ifconfig | grep "inet " | grep -Fv 127.0.0.1 | awk '{print $2}'
}

function find-and-prune() {
    find . -name $1 -prune | xargs \rm -rf
}

function copy-agent-files() {
    # AGENTS.md / CLAUDE.md
    local source_memory_file="$HOME/.config/agents/AGENTS.md"
    local ai_memory_files=(
        "$HOME/.claude/CLAUDE.md"
        "$HOME/.gemini/AGENTS.md"
        "$HOME/.factory/AGENTS.md"
    )
    local response

    if [[ ! -f "$source_memory_file" ]]; then
        echo "Source memory file not found: $source_memory_file" >&2
        return 1
    fi

    for memory_file in "${ai_memory_files[@]}"; do
        local memory_dir="${memory_file%/*}"
        mkdir -p "$memory_dir"
        if [[ -f "$memory_file" ]] && ! cmp -s "$source_memory_file" "$memory_file"; then
            echo -n "Destination $memory_file differs from source. Overwrite? [y/N]: "
            read -r response
            if [[ ! "$response" =~ ^([yY]|[yY][eE][sS])$ ]]; then
                echo "Copy aborted."
                return 0
            fi
        fi
        cp -f "$source_memory_file" "$memory_file"
    done

    # mcp.json
    local source_mcp_file="$HOME/.config/agents/mcp.json"

    if [[ ! -f "$source_mcp_file" ]]; then
        echo "Source mcp file not found: $source_mcp_file" >&2
        return 1
    fi

    # factory (link)
    local factory_mcp_file="$HOME/.factory/mcp.json"
    if [[ -f "$factory_mcp_file" ]] && ! cmp -s "$source_mcp_file" "$factory_mcp_file"; then
        echo -n "Destination $factory_mcp_file differs from source. Overwrite? [y/N]: "
        read -r response
        if [[ ! "$response" =~ ^([yY]|[yY][eE][sS])$ ]]; then
            echo "Copy aborted."
            return 0
        fi
    fi
    cp -f "$source_mcp_file" "$factory_mcp_file"

    # # gemini (merge)
    # TODO: gemini + claude
    # local gemini_dir="$HOME/.gemini"
    # local gemini_settings_file="$gemini_dir/settings.json"
    # local gemini_settings_file_merged="$gemini_settings_file.merged"
    #
    # mkdir -p "$gemini_dir"
    # [[ -f "$gemini_settings_file" ]] || echo '{}' > "$gemini_settings_file"
    #
    # jq -s '.[0] * {mcpServers: (.[1].mcpServers // {})}' \
    #     "$gemini_settings_file" "$source_mcp_file" > "$gemini_settings_file_merged" \
    #     && mv "$gemini_settings_file_merged" "$gemini_settings_file"
}
