#!/usr/bin/env bash
# Dwonloads replicated installer and TFE airgap package

which jq 1>/dev/null || {
    echo "==> 'jq' package not installed."
    exit 1
}

if [ -n  "$TFE_AIRGAP_DOWNLOAD_PASSWORD" -a -n "$TFE_LICENSE_ID" -a -n "$TFE_RELEASE_SEQUENCE" ]; then
    PASSWORD_B64=$(echo -n ${TFE_AIRGAP_DOWNLOAD_PASSWORD} | base64)
    TFE_AIRGAP_URL=$(curl -sSf \
        -H 'Content-Type: application/json' \
        -H "Authorization: Basic ${PASSWORD_B64}" \
        "https://api.replicated.com/market/v1/airgap/images/url?license_id=${TFE_LICENSE_ID}&sequence=${TFE_RELEASE_SEQUENCE}" \
        | jq -r '.url')
fi

[ -z $TFE_AIRGAP_URL ] && {
    echo "==> TFE_AIRGAP_URL not set."
    exit 1
}

if [ "${REPLICATED_VER}" ]; then
    REPLICATED_INSTALLER_URL="https://s3.amazonaws.com/replicated-airgap-work/stable/replicated-${REPLICATED_VER}%2B${REPLICATED_VER}%2B${REPLICATED_VER}.tar.gz"
else
    REPLICATED_INSTALLER_URL='https://s3.amazonaws.com/replicated-airgap-work/replicated.tar.gz'
fi

echo "==> downloading TFE airgap package from ${TFE_AIRGAP_URL}"
wget -nv -O /tmp/terraform-enterprise.airgap ${TFE_AIRGAP_URL} || {
    echo "==> failed downloading TFE airgap package."
    exit 1
}

echo "==> downloading Replicated installer from ${REPLICATED_INSTALLER_URL}"
wget -nv -O /tmp/replicated.tar.gz $REPLICATED_INSTALLER_URL || {
    echo "==> failed downloading Replicated installer package." 
    exit 1 
}
