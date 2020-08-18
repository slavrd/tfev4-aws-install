# TFEv4 AWS AMI

A packer project for the creation of an AWS AMI with ready for TFEv4 airgap install based on the TFE [documentation](https://www.terraform.io/docs/enterprise/install/automating-the-installer.html).

The resulting ami will have 
 - Docker CE installed 
 - The needed files to perform TFE airgap installation coped in `/opt/tfe-tfe-installer` directory. The user should still create the installation settings files as described [here](https://www.terraform.io/docs/enterprise/install/automating-the-installer.html).

## Prerequisites

* Have [`Packer`](https://packer.io/downloads.html) installed.
* A TFEv4 airgap package download link.
* Have TFE license in `assets/tfev4.rli`
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

- set the packer variables defined in `template.json`. Help on setting packer template variables can be found [here](https://packer.io/docs/templates/user-variables.html).
  - `base_ami_id` - must be an ubuntu image.
  - `tfev4_version` - a string used in the AMI name and for tagging.
  - `tfev4_url` - a URL from which to download the TFEv4 airgap package.
  - `replicated_version` - a version of the Replicated installer to download. Version can be checked [here](https://release-notes.replicated.com/). If not provided will use latest and will not set value for the `replicatad_version` ami tag.
  - `ami_tag_owner`, `ami_tag_project` and `ami_tag_ssl_cert_expiry` - the AMI wil be tagged with `owner`, `project` and `ssl_cert_expiry` tags using the corresponding values from the variables.

- use the `packer build` command to build the AMI. For example if using the `eu-central-1` AWS region:

```bash
packer build \
  -var 'base_ami_id=ami-0718a1ae90971ce4d' \
  -var 'tfev4_version=v201912-4' \
  -var 'tfev4_url=https://VALID_TFE_DOWNLOAD_URL'
  -var 'replicated_version=2.42.5' \
  -var 'ami_tag_owner=you@your.org' -var 'ami_tag_project=tfev4' \
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

## Testing

The project contains a [terratest](https://github.com/gruntwork-io/terratest) test placed in the `./test` directory. The test will

- Use `Packer` to build an AMI. The test can also be passed an existing AMI id via the `-ami` command line argument. In this case no new ami will be built.
- Use `Terraform` to provision an EC2 instance from this AMI.
- Run tests over ssh on the EC2 instance.

### Prerequisites 

- Have [Golang](https://golang.org/dl/) installed.
- Have [Packer](https://packer.io/downloads.html) installed.
- Have [Terraform](https://www.terraform.io/downloads.html) version `>= 0.12.20` installed.
- Have the go dependency packages installed. To do that run 

```
go get -v -d -t ./test/...
```

### Running the test

- Set any terraform input variables as needed. The terraform configuration used by the test is placed in `./test/terraform_fixture` directory. Any variables that do not have a default value are set by terratest and MUST NOT be set manually.

- Set AWS credentials by using AWS credentials file or environment variables. For example:

```bash
export AWS_ACCESS_KEY_ID=<YOUR AWS ACCESS KEY>
export AWS_SECRET_ACCESS_KEY=<YOUR AWS SECRET KEY>
```

- Set AWS_REGION environment variable

```bash
export AWS_REGION=<THE AWS REGION TO CREATE THE AMI>
```

- Increase the time packer will wait for AWS resources to report ready status. 

```bash
export AWS_TIMEOUT_SECONDS=3600
```

At this point the test can be run so that it will build a new AMI with packer or the tests can be provided an existing ami to run against.

- Run the full test - build a new AMI with packer, provision VM based on it, run tests on it, clean up. In this case need to
  - pass the `-url` flag to set the `tfev4_url` packer input variable.
  - pass the `-ver` flag so the test will set the `tfev4_version` packer template variable.
  - (optional) pass the `-replicated-ver` flag to set the `replicated_version` packer template variable.

```bash
go test -v -timeout 60m ./test/ -ver 'v201912-4' -url 'https://VALID_TFE_DOWNLOAD_URL'
```

- Run tests against an existing ami
  
```bash
go test -v -timeout 60m ./test/ -ami 'aws_ami_id'
```
