#!/usr/bin/env bash
# Dwonloads replicated installer and ptfe airgap package

[ -z $PTFE_AIRGAP_URL ] && {
    echo "==> PTFE_AIRGAP_URL not set"
    exit 1
}
[ -z $REPLICATED_VER ] && {
    REPLICATED_INSTALLER_URL='https://s3.amazonaws.com/replicated-airgap-work/replicated.tar.gz'
} || {
    REPLICATED_INSTALLER_URL="https://s3.amazonaws.com/replicated-airgap-work/stable/replicated-${REPLICATED_VER}%2B${REPLICATED_VER}%2B${REPLICATED_VER}.tar.gz"
}

echo "==> downloading PTFE airgap package from ${PTFE_AIRGAP_URL}"
wget -nv -O /tmp/terraform-enterprise.airgap $PTFE_AIRGAP_URL || {
    echo "==> failed downloading PTFE airgap package"
    exit 1
}

echo "==> downloading Replicated installer from ${REPLICATED_INSTALLER_URL}"
wget -nv -O /tmp/replicated.tar.gz $REPLICATED_INSTALLER_URL || {
    echo "==> failed downloading Replicated installer package" 
    exit 1 
}

exit 0
