#export DOCKER_HOST="unix://$HOME/.colima/default/docker.sock"

# From https://github.com/testcontainers/testcontainers-java/issues/5034#issuecomment-1319812252
#export TESTCONTAINERS_HOST_OVERRIDE=$(colima ls -j | jq -r '.address')
#export TESTCONTAINERS_DOCKER_SOCKET_OVERRIDE=/var/run/docker.sock
