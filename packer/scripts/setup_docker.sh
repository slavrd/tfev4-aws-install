#/usr/bin/env bash
# Installs Docker Engine - Community

sudo apt-get update

# Install packages to allow apt to use a repository over HTTPS
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common \
    jq

# Add docker GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Set up the stable repository
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# install the latest version of the Docker Engine - Comunity
sudo apt-get update

[ -z "$DOCKER_VERSION_STRING" ] \
&& sudo apt-get install -y docker-ce docker-ce-cli containerd.io \
|| sudo apt-get install -y docker-ce=${DOCKER_VERSION_STRING} docker-ce-cli=${DOCKER_VERSION_STRING} containerd.io