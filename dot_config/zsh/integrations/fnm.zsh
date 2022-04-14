eval "$(fnm env --use-on-cd)"

# Add command to install common global packages I use
# This is in same form as pyenv update command
# TODO: make this better
function install_global_node_packages() {
    npm install -g @fsouza/prettierd eslint_d
}
