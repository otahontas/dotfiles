# General utility functions

# Create folder and cd to it
function mcd() {
    mkdir "$1" && cd "$1"
}

# Cd to folder and list content
function cl() {
    cd "$1" && ls .
}

# Show listening ports
function listening() {
    if [ $# -eq 0 ]; then
        sudo lsof -iTCP -sTCP:LISTEN -n -P
    elif [ $# -eq 1 ]; then
        sudo lsof -iTCP -sTCP:LISTEN -n -P | grep -i --color $1
    else
        echo "Usage: listening [pattern]"
    fi
}

# Show local IP addresses
function myip() {
    ifconfig | grep "inet " | grep -Fv 127.0.0.1 | awk '{print $2}'
}

# Find and remove directories/files by name
function find-and-prune() {
    if [[ -z "$1" ]]; then
        echo "Usage: find-and-prune PATTERN"
        return 1
    fi

    echo "This will delete all files/directories matching: $1"
    echo -n "Are you sure? [y/N] "
    read -r response

    case "$response" in
        [yY]|[yY][eE][sS])
            find . -name "$1" -prune -print0 | xargs -0 rm -rf
            ;;
        *)
            echo "Cancelled"
            ;;
    esac
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
# Usage: print-color COLOR_CODE
function print-color() {
    local color="%F{$1}"
    echo -E ${(qqqq)${(%)color}}
}

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

# macOS sleep control
function disable-sleep() {
    sudo pmset -a disablesleep 1
}

function enable-sleep() {
    sudo pmset -a disablesleep 0
}
