# Wrapper for nnn to cd on quit

function nnn () {
    # Block nesting of nnn in subshells
    if [ -n $NNNLVL ] && [ "${NNNLVL:-0}" -ge 1 ]; then
        echo "nnn is already running"
        return
    fi

    # NNN_TMPFILE is fixed, should not be modified
    export NNN_TMPFILE="${XDG_CONFIG_HOME}/nnn/.lastd"

    TERM=xterm command nnn "$@"

    if [ -f "$NNN_TMPFILE" ]; then
            . "$NNN_TMPFILE"
            # Escape rm, since rm is aliased to trash
            \rm -f "$NNN_TMPFILE" > /dev/null
    fi
}

# OPTS: Show hidden files, use EDITOR and VISUAL for text files
export NNN_OPTS="ceEH"
# Use trash instead of delete
export NNN_TRASH="1"
# Use custom opener
export NNN_OPENER="${HOME}/.local/bin/open"
