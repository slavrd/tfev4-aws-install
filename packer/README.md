# PTFEv4 AWS AMI

A packer project for the creation of an AWS AMI with ready for TFEv4 airgap install based on the TFE [documentation](https://www.terraform.io/docs/enterprise/install/automating-the-installer.html).

The resulting ami will have 
 - Docker CE installed 
 - The needed files to perform TFE airgap installation coped in `/opt/tfe-tfe-installer` directory. The user should still create the installation settings files as described [here](https://www.terraform.io/docs/enterprise/install/automating-the-installer.html).

## Prerequisites

* Have [`Packer`](https://packer.io/downloads.html) installed.
* Have Replicated [installer](https://s3.amazonaws.com/replicated-airgap-work/replicated.tar.gz ) in `assets/replicated.tar.gz`
* Have TFE airgap package in `assets/terraform-enterprise.airgap`
* Have TFE license in `assets/ptfev4.rli`
* Have the a valid SSL certificate and private key in
  * `assets/cert.pem`
  * `assets/privkey.pem`

The project relies on the asset files being named as described above.

## Building the AMI

Once the assets and configuration files are ready to build the AMI:

- set AWS credentials by using AWS credentials file or environment variables. For example:

```bash
export AWS_ACCESS_KEY_ID=<YOUR AWS ACCESS KEY>
export AWS_SECRET_ACCESS_KEY=<YOUR AWS SECRET KEY>
export AWS_REGION=<THE AWS REGION TO CREATE THE AMI>
```
- Increase the time packer will wait for AWS resources to report ready status. The AMI in this template has a root ebs volume of 50GB and so it takes a long time to build. This sometimes causes a packer to timeout waiting for the AMI to become ready.

```bash
export AWS_TIMEOUT_SECONDS=3600
```

- set the packer variables defined in `template.json`.vHelp on setting packer template variables can be found [here](https://packer.io/docs/templates/user-variables.html).
  - `base_ami_id` - must be an ubuntu image.
  - `ptfev4_version` - a string used in the AMI name.
  - `tag_owner` and `tag_project` - the AMI wil be tagged with `owner` and `project` tags using the corresponding values from the variables.

- use the `packer build` command to build the AMI. For example if using the `eu-central-1` AWS region:

```bash
packer build \
  -var 'base_ami_id=ami-0718a1ae90971ce4d' \
  -var 'ptfev4_version=v201912-4' \
  -var 'tag_owner=you@your.org' -var 'tag_project=ptfev4' \
  template.json
```

## Using the AMI

The AMI will have all the assets placed in `/opt/tfe-tfe-installer`.

Use the `/opt/tfe-tfe-installer/install.sh` to install replicated and TFE as described [here](https://www.terraform.io/docs/enterprise/install/automating-the-installer.html). For example:

1. Create the needed settings files `/etc/replicated.conf` and e.g. `settings.json`.

2. Run

```bash
sudo su -
cd /opt/tfe-installer/

private_ip=$(curl -sS 'http://169.254.169.254/latest/meta-data/local-ipv4')
public_ip=$(curl -sS 'http://169.254.169.254/latest/meta-data/public-ipv4')

./install.sh airgap no-proxy private-address=$private_ip public-address=$public_ip
```

The installation commands can be placed in the instance user data so that the install is automated upon instance launch.
