#!/bin/sh
echo "
         ######################################
         ###        Base image test          ##
         ######################################
"

# If parameter is not path do dockerfile
if [ "$1" = "" ]; then
    DOCKERFILE=$BASE/Dockerfile
else
    DOCKERFILE=$1
fi

# Check for command existence
# See: https://www.shivering-isles.com/helpful-shell-snippets-for-docker-testing-and-bootstrapping/
command_exits() { command -v $1 >/dev/null 2>&1 || { echo >&2 "I require $1 but it's not installed.  Aborting."; exit 1; }; }

# Docker latest version tag
# See: https://www.shivering-isles.com/helpful-shell-snippets-for-docker-testing-and-bootstrapping/
docker_image_latest_tag() { REPO=$1; [ $(echo $REPO | grep '/' | wc -l) -eq 0 ] && REPO=library/$1; wget -q -O- https://registry.hub.docker.com/v2/repositories/${REPO}/tags | jq .results[].name | sort -V | sed -e 's/"//g' | grep -P '[[:digit:]]+((.[[:digit:]]+)?.[[:digit:]]+)' | tail -1; }

# Version comparison greater or equal
# See: https://www.shivering-isles.com/helpful-shell-snippets-for-docker-testing-and-bootstrapping/
version_ge() { test "$(printf '%s\n' "$@" | sort -V | head -n 1)" != "$1" || test "$1" = "$2"; }

# Docker base image version
# See: https://www.shivering-isles.com/helpful-shell-snippets-for-docker-testing-and-bootstrapping/
docker_base_version() { cat "$1" | grep FROM | sed -e "s/FROM.*://g"; }

# Docker base image name
# See: https://www.shivering-isles.com/helpful-shell-snippets-for-docker-testing-and-bootstrapping/
docker_base_name() { cat "$1" | grep FROM | sed -e "s/FROM[^[:alpha:]]//g" -e "s/:.*//g"; }

command_exits wget

version_ge $(docker_base_version "$DOCKERFILE") $(docker_image_latest_tag `docker_base_name "$DOCKERFILE"`) && echo "$DOCKERFILE: Base image is up to date! Test successful." || { echo >&2 "$DOCKERFILE: A newer base image is available! Please update."; exit 1; }
