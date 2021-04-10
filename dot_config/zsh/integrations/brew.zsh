# Add brew sbin to path
[[ $PATH != *"/usr/local/sbin"* ]] && export PATH=/usr/local/sbin:$PATH

# Wrapper for brew to execute brewfile dumping on certain brew commands
function brew () {
    local dump_commands=("install" "uninstall" "tap" "untap")
    local main_command="${1}"
    local brewfile_path="$(chezmoi source-path)/mac/packages/Brewfile"

    command brew ${@}

    for command in "${dump_commands[@]}"; do
        [[ "${command}" == "${main_command}" ]] && brew bundle dump --file="$brewfile_path" --force
    done
}
