# Set pyenv root to path
[[ $PATH != *"$PYENV_ROOT/bin"* ]] && export PATH="$PYENV_ROOT/bin:$PATH"

# Load pyenv executable from path
eval "$(pyenv init --path)"

# Load pyev
eval "$(pyenv init -)"

# Add command to update (install if not already there) common global python packages
function update_global_python_packages {
    pip install --upgrade pip networkx jupyter numpy scipy matplotlib pandas sympy pynvim
}

# Add command to update global pyenv

# Add script to update pyenv + install some packages I use globally
# TODO: make this better
function update_global_python() {
    version_to_install=$1
    if [ -z "$version_to_install" ]; then
        echo "No version specified, can't continue"
        return 1
    fi
    current_version=$(pyenv global)
    if [[ "$current_version" == "$version_to_install" ]]; then
        echo "Python $version_to_install is already installed, continuing to update packages."
    else
        echo "Installing Python $version_to_install"
        pyenv install $version_to_install
        pyenv global $version_to_install
        pyenv uninstall $current_version
    fi
    update_global_python_packages
}
