# Terraform - PTFEv4 EC2 Instance

A project to deploy PTFEv4 and its external service in AWS, according to HashiCorp AWS reference [architecture](https://www.terraform.io/docs/enterprise/install/automating-the-installer.html).

The Terraform configuration is divided into sub-modules. The root module in this directory is used to tie them together so that all resources can be provisioned with a single run e.g. for a demo.

## Prerequisites

* Have Terraform `~> 0.12.20` [installed](https://www.terraform.io/downloads.html).
* Have AWS account with permissions as described [here](https://www.terraform.io/docs/enterprise/before-installing/reference-architecture/aws.html#additional-aws-resources).

## Sub Modules

The resource configuration is split in the following modules placed in sub directories.

* `asg-ec2-instance` - provisions an Auto Scaling group to deploy an EC2 instance with PTFEv4 installed. Assumes it is provided an AMI built with the Packer [project](../packer/README.md) in this repository. Details on what the module does are in its [readme](./asg-ec-instance/README.md).

* `dns` - provisions a CNAME DNS record in AWS route53. Details on what the module does are in its [readme](./dns/README.md).

* `ext-services` - external services needed for the PTFEv4 installation. An PostgreSQL RDS instance and a S3 bucket. Details on what the module does are in its [readme](./ext-services/README.md).

* `network` - network resources needed for the PTFEv4 installation. A VPC, S3 access point for it and private and public subnets. Details on what the module does are in its [readme](./network/README.md).

* `key-pair` - can create a key pair for the PTFE EC2 instance. Can also be disabled in case an externally created key pair should be used. Details on what the module does are in its [readme](./key-pair/README.md).

* `ec2-instance` - (not used) provisions an EC2 instance with PTFEv4 installed. Assumes it is provided an AMI built with the Packer [project](../packer/README.md) in this repository. Details on what the module does are in its [readme](./ec-instance/README.md).

## Usage

This directory contains the Terraform code that ties the sub modules together. Each sub module can also be used individually by going to its sub directory.

To provision the infrastructure with Terraform:

- set the Terraform module input variables as described [here](https://www.terraform.io/docs/configuration/variables.html#assigning-values-to-root-module-variables). Variables for the modules are placed in `variables.*.tf` files. Each variable has a description of what it us used for and many have default values provided as well.

  The file `example.tfvars` is an example of a minimum needed input variables to successfully apply the Terraform configuration.

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
