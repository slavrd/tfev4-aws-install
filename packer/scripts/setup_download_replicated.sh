#!/usr/bin/env bash
# Dwonloads replicated installer and TFE airgap package

[ -z $TFE_AIRGAP_URL ] && {
    echo "==> TFE_AIRGAP_URL not set"
    exit 1
}

if [ "${REPLICATED_VER}" ] ; then
         REPLICATED_INSTALLER_URL="https://s3.amazonaws.com/replicated-airgap-work/stable/replicated-${REPLICATED_VER}%2B${REPLICATED_VER}%2B${REPLICATED_VER}.tar.gz"
else
        REPLICATED_INSTALLER_URL='https://s3.amazonaws.com/replicated-airgap-work/replicated.tar.gz'
fi

echo "==> downloading TFE airgap package from ${TFE_AIRGAP_URL}"
wget -nv -O /tmp/terraform-enterprise.airgap $TFE_AIRGAP_URL || {
    echo "==> failed downloading TFE airgap package"
    exit 1
}

echo "==> downloading Replicated installer from ${REPLICATED_INSTALLER_URL}"
wget -nv -O /tmp/replicated.tar.gz $REPLICATED_INSTALLER_URL || {
    echo "==> failed downloading Replicated installer package" 
    exit 1 
}
