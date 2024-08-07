# Setup docker to respect xdg
export DOCKER_CONFIG=$XDG_CONFIG_HOME/docker

# Setup testcontainers with colima: https://node.testcontainers.org/supported-container-runtimes/
export DOCKER_HOST=unix://${HOME}/.colima/default/docker.sock
export TESTCONTAINERS_DOCKER_SOCKET_OVERRIDE=/var/run/docker.sock
export NODE_OPTIONS=--dns-result-order=ipv4first
