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
        local read_result
        if read_result=$(cat "$timestamp_file" 2>&1); then
            # Validate it's a number
            if [[ "$read_result" =~ ^[0-9]+$ ]]; then
                last_run=$read_result
            else
                echo "⚠️  Warning: Invalid timestamp in $timestamp_file (found: '$read_result')" >&2
                echo "   Run 'update-packages' to reset the timestamp." >&2
                return 1
            fi
        else
            echo "⚠️  Warning: Failed to read timestamp file: $timestamp_file" >&2
            echo "   Error: $read_result" >&2
            return 1
        fi
    fi

    # Check if 24 hours (86400 seconds) have passed
    local time_diff=$((current_time - last_run))
    if [[ $time_diff -ge 86400 ]]; then
        if [[ $last_run -eq 0 ]]; then
            echo -n "Update packages? (First run) [y/N]: "
        else
            echo -n "Update packages? It's been $(($time_diff / 3600)) hours since last run. [y/N]: "
        fi
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

# Check Homebrew bash is in /etc/shells
function check-homebrew-bash() {
    local brew_bash="/opt/homebrew/bin/bash"

    # Skip if Homebrew bash doesn't exist
    [[ ! -x "$brew_bash" ]] && return

    if ! grep -qE "^${brew_bash}/?$" /etc/shells 2>/dev/null; then
        echo "⚠️  Homebrew bash not in /etc/shells. To add:"
        echo "   sudo sh -c 'echo $brew_bash >> /etc/shells'"
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
    echo "\nUpdating Neovim plugins and external deps (lsps, formatters, linters, daps)..."
    if command -v nvim &> /dev/null; then
        nvim --headless -c "lua vim.pack.update({}, {force=true})" -c "qall"
        nvim --headless -c "MasonUpdate" -c "qall"
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

# === git-worktree funcs ===
function _git_worktree_init() {
    export HUSKY=0
    git root 2>/dev/null || { echo "Error: Not in a git repository" >&2; return 1; }
}

function _git_worktree_has_git_crypt() {
    local repo_root="$1"
    [ -d "$repo_root/.git/git-crypt" ]
}

function _git_worktree_get_path() {
    local repo_root="$1"
    local branch_name="$2"

    mkdir -p "$repo_root/.worktrees"
    echo "$repo_root/.worktrees/$branch_name"
}

function _git_worktree_create_and_enter() {
    local repo_root="$1"
    local worktree_path="$2"
    local branch_name="$3"
    # get remaining
    shift 3 
    local git_worktree_args=("$@")

    if _git_worktree_has_git_crypt "$repo_root"; then
        echo "Detected git-crypt encryption"
        git -c filter.git-crypt.smudge=cat -c filter.git-crypt.clean=cat worktree add "$worktree_path" "${git_worktree_args[@]}"

        local worktree_basename=$(basename "$worktree_path")
        ln -s "$repo_root/.git/git-crypt" "$repo_root/.git/worktrees/$worktree_basename/git-crypt"

        cd "$worktree_path"
        git co -- . 2>/dev/null || true
    else
        git worktree add "$worktree_path" "${git_worktree_args[@]}"
        cd "$worktree_path"
    fi
}

function _git_worktree_verify_status() {
    local worktree_status=$(git s --short)
    if [ -n "$worktree_status" ]; then
        echo "Warning: Worktree has uncommitted changes:"
        echo "$worktree_status"
    fi
}

# Public functions
function git-worktree-new() {
    if [ -z "$1" ]; then
        echo "Usage: git-worktree-new BRANCH_NAME"
        echo ""
        echo "Creates a new git worktree with automatic git-crypt support."
        echo "Worktrees are created in .worktrees/ directory."
        return 1
    fi

    local branch_name="$1"
    local repo_root=$(_git_worktree_init) || return 1
    local worktree_path=$(_git_worktree_get_path "$repo_root" "$branch_name")

    echo "Creating worktree for branch: $branch_name"
    echo "Location: $worktree_path"

    _git_worktree_create_and_enter "$repo_root" "$worktree_path" "$branch_name" -b "$branch_name"
    _git_worktree_verify_status

    echo ""
    echo "✓ Worktree created successfully"
}

function git-worktree-pr() {
    if [ -z "$1" ]; then
        echo "Usage: git-worktree-pr PR_NUMBER"
        echo ""
        echo "Checks out a GitHub PR for review in an isolated worktree."
        echo "Automatically handles git-crypt if present."
        return 1
    fi

    local pr_number="$1"
    local repo_root=$(_git_worktree_init) || return 1

    # Get PR branch name from GitHub
    local pr_branch=$(gh pr view "$pr_number" --json headRefName -q .headRefName 2>/dev/null)
    local branch_name="$pr_branch"
    local worktree_dir_name="pr-$pr_number-$pr_branch"

    local worktree_path=$(_git_worktree_get_path "$repo_root" "$worktree_dir_name")

    echo "Fetching PR #$pr_number..."
    git fetch origin "pull/$pr_number/head:$branch_name" 2>&1 | grep -v "^From" || true

    echo "Creating worktree for PR #$pr_number..."

    _git_worktree_create_and_enter "$repo_root" "$worktree_path" "$branch_name" "$branch_name"
    _git_worktree_verify_status

    echo ""
    echo "✓ PR #$pr_number checked out successfully"
    echo "Location: $worktree_path"
}

function git-worktree-prune() {
    if [ -z "$1" ]; then
        echo "Usage: git-worktree-prune BRANCH_NAME"
        echo ""
        echo "Removes a git worktree and deletes its branch."
        echo ""
        echo "This will:"
        echo "  1. Remove the worktree directory"
        echo "  2. Delete the branch (using -D to force delete)"
        return 1
    fi

    local branch_name="$1"
    local repo_root=$(_git_worktree_init) || return 1
    local worktree_path="$repo_root/.worktrees/$branch_name"

    if [ ! -d "$worktree_path" ]; then
        echo "Error: Could not find worktree for branch '$branch_name'"
        echo ""
        echo "Available worktrees:"
        git worktree list
        return 1
    fi

    echo "Removing worktree: $worktree_path"
    if git worktree remove "$worktree_path" --force; then
        echo "✓ Worktree removed"
    else
        return 1
    fi

    # Delete the branch
    if git show-ref --verify --quiet "refs/heads/$branch_name"; then
        echo "Deleting branch: $branch_name"
        if git br -D "$branch_name"; then
            echo "✓ Branch deleted"
        fi
    fi
}

# Completion for git-worktree-prune
_git-worktree-prune() {
    local repo_root=$(git root 2>/dev/null)
    if [ -n "$repo_root" ] && [ -d "$repo_root/.worktrees" ]; then
        local -a branches
        branches=(${repo_root}/.worktrees/*(/:t))
        _describe 'worktree branch' branches
    fi
}
compdef _git-worktree-prune git-worktree-prune

# Completion for git-worktree-pr
_git-worktree-pr() {
    local -a prs
    local pr_list=$(gh pr list --limit 50 --json number,title --jq '.[] | "\(.number):\(.title)"' 2>/dev/null)
    if [ -n "$pr_list" ]; then
        while IFS= read -r line; do
            prs+=("$line")
        done <<< "$pr_list"
        _describe 'pull request' prs
    fi
}
compdef _git-worktree-pr git-worktree-pr

# Combine PDFs from a folder into a single PDF
function combine-pdfs-in-folder() {
  local folder="${1:-.}"

  # Remove trailing slash if present
  folder="${folder%/}"

  # Get basename of folder
  local basename="${folder:t}"

  # Get all PDF files sorted
  local pdfs=("${folder}"/*.pdf(N))

  if [[ ${#pdfs} -eq 0 ]]; then
    echo "No PDF files found in ${folder}"
    return 1
  fi

  # Output file
  local output="${basename}.pdf"

  echo "Combining ${#pdfs} PDFs from ${folder} into ${output}..."

  pdfunite "${pdfs[@]}" "${output}"

  if [[ $? -eq 0 ]]; then
    echo "Created ${output}"
  else
    echo "Failed to create ${output}"
    return 1
  fi
}
