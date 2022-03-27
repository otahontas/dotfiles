# Guide lazydocker to use colima as docker host
alias lazydocker="DOCKER_HOST=$(docker context inspect | jq '.[] .Endpoints.docker.Host' -r) command lazydocker"

# Add easier alias
alias lzd="lazydocker"
