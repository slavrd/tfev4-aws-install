#!/ust/bin/env bash
# Copies setup files from /tmp to appropriate directories

[ -d /opt/tfe-installer/ ] || mkdir -p /opt/tfe-installer/

cp /tmp/assets/terraform-enterprise.airgap /opt/tfe-installer/terraform-enterprise.airgap

cp /tmp/assets/ptfev4.rli /opt/tfe-installer/ptfev4.rli

tar -zvxf /tmp/assets/replicated.tar.gz -C /opt/tfe-installer/

cp /tmp/assets/cert.pem /opt/tfe-installer/cert.pem

cp /tmp/assets/privkey.pem /opt/tfe-installer/privkey.pem
