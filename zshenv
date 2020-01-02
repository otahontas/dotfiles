# Note: This file is always sourced and should always be symlinked to $HOME/.zshenv

# Set XDG Base Directories
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_DATA_DIRS=/usr/local/share:/usr/share
export XDG_CONFIG_DIRS=/etc/xdg

# Set some programs to use XDG Base Directories
export DOCKER_CONFIG=$XDG_CONFIG_HOME/docker
export GNUPGHOME=$XDG_DATA_HOME/gnupg
export GRADLE_USER_HOME=$XDG_DATA_HOME/gradle
export PASSWORD_STORE_DIR=$XDG_DATA_HOME/pass
export RUSTUP_HOME=$XDG_DATA_HOME/rustup
export WGETRC=$XDG_CONFIG_HOME/wgetrc
export ZDOTDIR=$XDG_CONFIG_HOME/zsh

# Enable Wayland for Firefox
export MOZ_ENABLE_WAYLAND=1

# Set up visual and editor
export VISUAL=nvim
export EDITOR=$VISUAL

# Allow systemd user to start ssh-agent
export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/ssh-agent.socket

# Add yarn installed global packages to path
export PATH=$PATH:$XDG_DATA_HOME/yarn/global/node_modules/.bin/
