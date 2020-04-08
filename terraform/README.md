# Terraform - TFEv4 EC2 Instance

A project to deploy TFEv4 and its external service in AWS, according to HashiCorp AWS reference [architecture](https://www.terraform.io/docs/enterprise/before-installing/reference-architecture/aws.html).

The Terraform configuration is divided into sub-modules. The root module in this directory is used to tie them together so that all resources can be provisioned with a single run e.g. for a demo.

## Prerequisites

* Have Terraform `~> 0.12.20` [installed](https://www.terraform.io/downloads.html).
* Have AWS account with permissions as described [here](https://www.terraform.io/docs/enterprise/before-installing/reference-architecture/aws.html#additional-aws-resources).

## Sub Modules

The resource configuration is split in the following modules placed in sub directories.

* `asg-ec2-instance` - provisions an Auto Scaling group to deploy an EC2 instance with TFEv4 installed. Assumes it is provided an AMI built with the Packer [project](../packer/README.md) in this repository. Details on what the module does are in its [readme](./asg-ec2-instance/README.md).

* `dns` - provisions a CNAME DNS record in AWS route53. Details on what the module does are in its [readme](./dns/README.md).

* `ext-services` - external services needed for the TFEv4 installation. An PostgreSQL RDS instance and a S3 bucket. Details on what the module does are in its [readme](./ext-services/README.md).

* `network` - network resources needed for the TFEv4 installation. A VPC, S3 access point for it and private and public subnets. Details on what the module does are in its [readme](./network/README.md).

* `key-pair` - can create a key pair for the TFE EC2 instance. Can also be disabled in case an externally created key pair should be used. Details on what the module does are in its [readme](./key-pair/README.md).

## Usage

This directory contains the Terraform code that ties the sub modules together. Each sub module can also be used individually by going to its sub directory.

### Input Variables

Variables for the modules are placed in `variables.*.tf` files. Each variable has a description of what it us used for and many have default values provided as well.

The table below contains the input variables available for the root Terraform module. Any variables that do not have a `default` value must be set by the user.

The file `example.tfvars` is an example of a minimum set of input variables needed to successfully apply the Terraform configuration.

| Variable | Type | Default | Description |
| -------- | ---- | ------- | ----------- |
| common_tags | map(string) | {} | Common tags to assign to all resources. |
| name_prefix | string | "tfe-" | A string to be used as prefix for generating names of the created resources. |
| vpc_cidr_block | string | | CIDR for the VPC to create. |
| public_subnets_cidrs | list(object({cidr=string, az_index=number})) | | List of objects representing the public subnets CIDRs and their availability zones. The az_index property is used as an index to retrieve a zone from the list of the availability zones for the current AWS region. Check example.tfvars for example values. |
| private_subnets_cidrs | list(object({cidr=string, az_index=number})) | | List of objects representing the private subnets CIDRs and their availability zones. The az_index property is used as an index to retrieve a zone from the list of the availability zones for the current AWS region. Check example.tfvars for example values. |
| lb_internal | bool | false | Whether to create internal load balancer. |
| s3_bucket_name | string | | Name of the s3 bucket to create. |
| s3_bucket_region | string | | The AWS region in which to create the s3 bucket. |
| pg_instance_class | string | "db.m4.large" | The instance class of the PostgreSQL instance. |
| pg_engine_version | string | "10.10" | The engine version of the PostgreSQL instance. |
| pg_allocated_storage | number | 100 | Storage amount in GBs to allocate for the PostgreSQL instance. |
| pg_storage_type | string | "gp2" | Storage type used by the PostgreSQL instance. |
| pg_multi_az | bool | false | Specifies if the PostgreSQL instance is multi-AZ. |
| pg_parameter_group_name | string | null | Name of the DB parameter group to associate. |
| pg_deletion_protection | bool | false | If the PostgreSQL instance should have deletion protection enabled. |
| pg_backup_retention_period | number | 0 | The days to retain backups for. Must be between 0 and 35. |
| pg_db_name | string | "tfe" | The name of the database to create when the PostgreSQL instance is created. |
| pg_username | string | "postgres" | Username for the master PostgreSQL instance user. |
| pg_password | string | | Password for the master PostgreSQL instance user. |
| ami_id | string | | The AMI Id to use for the tfe instance. Needs to have the TFE arigap package and Replicated installer. |
| key_name | string | | Name of the AWS key pair to use for the tfe instance. |
| key_pair_create | bool | false | Wether to create an AWS key pair at all. If false the `key_name` variable must be set to an existing aws ec2 key pair. |
| public_key_path | string | "" | Public key to use for the AWS key pair creation. If not provided a new TLS public/private key pair will be generated. |
| instance_type | string | "m5a.large" | The AWS instance type to use. |
| root_block_device_size | number | 50 | The size of the root block device volume in gigabytes. |
| replicated_password | string | | Password to set for the replaicated console. |
| tfe_hostname | string | | Hostname which will be used to access the tfe instance. |
| tfe_enc_password | string | | Encryption password to be used by tfe. |
| tfe_associate_public_ip_address | bool | false | Wether to associate public ip address with the instance. Should be false except if bringing up standalone instance for testing. |

### Provisioning with Terraform

- set the Terraform module input variables as described [here](https://www.terraform.io/docs/configuration/variables.html#assigning-values-to-root-module-variables).

- Set AWS credentials according to the Terraform AWS provider [documentation](https://www.terraform.io/docs/providers/aws/index.html).

- Set the AWS region by setting AWS_REGION environment variable if not using a AWS credentials profile where it is already defined.

- check and confirm the changes terraform will make to the infrastructure
  
  ```bash
  terraform plan
  ```
- provision the infrastructure

  ```bash
  terraform apply
  ```
