# Wrapper for nnn to cd on quit
#
function nnn () {
    # Block nesting of nnn in subshells
    if [ -n $NNNLVL ] && [ "${NNNLVL:-0}" -ge 1 ]; then
        echo "nnn is already running"
        return
    fi

    # NOTE: NNN_TMPFILE is fixed, should not be modified
    export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

    command nnn "$@"

    if [ -f "$NNN_TMPFILE" ]; then
            . "$NNN_TMPFILE"
            # Escape rm, since rm is aliased to trash
            \rm -f "$NNN_TMPFILE" > /dev/null
    fi
}

# OPTS: Show hidden files, use EDITOR and VISUAL for text files
export NNN_OPTS="eEH"
# Use trash instead of delete
export NNN_TRASH="1"
