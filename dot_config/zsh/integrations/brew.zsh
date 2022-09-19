# Add brew sbin to path
[[ $PATH != *"/usr/local/sbin"* ]] && export PATH=/usr/local/sbin:$PATH

# Wrapper for brew to execute brewfile dumping on certain brew commands
# TODO: fix some possibly erronous stuff (shellcheck this)
function brew () {
    local dump_commands=("install" "uninstall" "tap" "untap" "upgrade")
    local main_command="${1}"
    local brewfile_path="$(chezmoi source-path)/mac/packages/Brewfile-$(scutil --get ComputerName)"

    command brew ${@}

    for command in "${dump_commands[@]}"; do
        [[ "${command}" == "${main_command}" ]] && brew bundle dump --file="$brewfile_path" --force
    done
}

# Replace stupid bsd based mac os tools with proper unix versions from brew
[[ $PATH != *"/usr/local/opt/gnu-time"* ]] && export PATH="/usr/local/opt/gnu-time/libexec/gnubin:$PATH"
[[ $PATH != *"/usr/local/opt/grep"* ]] && export PATH="/usr/local/opt/grep/libexec/gnubin:$PATH"
[[ $PATH != *"/usr/local/opt/coreutils"* ]] && export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
