#!/ust/bin/env bash
# Copies setup files from /tmp to appropriate directories

[ -d /opt/tfe-installer/ ] || mkdir -p /opt/tfe-installer/

cp /tmp/terraform-enterprise.airgap /opt/tfe-installer/terraform-enterprise.airgap

cp /tmp/ptfev4.rli /opt/tfe-installer/ptfev4.rli

tar -zvxf /tmp/replicated.tar.gz -C /opt/tfe-installer/

cp /tmp/cert.pem /opt/tfe-installer/cert.pem

cp /tmp/privkey.pem /opt/tfe-installer/privkey.pem
