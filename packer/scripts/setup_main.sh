#/usr/bin/env bash

# Sets up the image - install packeges, make configurations etc.
apt-get update

# Install packages to allow apt to use a repository over HTTPS
apt-get install -y apt-transport-https \
    ca-certificates curl gnupg-agent \
    software-properties-common jq \
    awscli ctop htop

# Add docker GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

# Set up the stable repository
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# install the latest version of the Docker Engine - Comunity
apt-get update

[ -z "$DOCKER_VERSION_STRING" ] \
&& apt-get install -y docker-ce docker-ce-cli containerd.io \
|| apt-get install -y docker-ce=${DOCKER_VERSION_STRING} docker-ce-cli=${DOCKER_VERSION_STRING} containerd.io

# Disable the release upgrader
echo "==> Disabling the release upgrader"
sed -i.bak 's/^Prompt=.*$/Prompt=never/' /etc/update-manager/release-upgrades

echo "==> Display version of Ubuntu"
. /etc/lsb-release

# Disable periodic apt upgrades
if [[ $DISTRIB_RELEASE == 16.04 || $DISTRIB_RELEASE == 18.04 ]]; then
    echo "==> Disabling periodic apt upgrades"
    echo 'APT::Periodic::Enable "0";' >> /etc/apt/apt.conf.d/10periodic
fi