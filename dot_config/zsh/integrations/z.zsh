# load z
source $(brew --prefix)/etc/profile.d/z.sh

# setup z to work with fzf: https://junegunn.github.io/fzf/examples/directory-nagivation/#integration-with-fzf
# unbind z
unalias z 2> /dev/null
# define custom z func
z() {
  local dir=$(
    _z 2>&1 |
    fzf --height 40% --layout reverse --info inline \
        --nth 2.. --tac --no-sort --query "$*" \
        --bind 'enter:become:echo {2..}'
  ) && cd "$dir"
}
