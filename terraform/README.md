# Terraform - PTFEv4 EC2 Instance

A project to build an EC2 Instance with installed PTFEv4, according to HashiCorp AWS reference [architecture](https://www.terraform.io/docs/enterprise/install/automating-the-installer.html).

The Terraform configuration is divided into sub-modules. The root module in this directory is used to tie them together so that all resources can be provisioned with a single run e.g. for a demo.

## Prerequisites

* Have Terraform `~> 0.12.20` [installed](https://www.terraform.io/downloads.html).
* Have AWS account with permissions as described [here](https://www.terraform.io/docs/enterprise/before-installing/reference-architecture/aws.html#additional-aws-resources).

## Sub Modules

The resource configuration is split in the following modules placed in sub directories.

* `ec2_instance` - provisions an EC2 instance with PTFEv4 installed. Assumes it is provided an AMI built with the Packer [project](../packer/README.md) in this repository. Details on what the module does are in its [readme](./ec-instance/README.md).

* `dns` - provisions a CNAME DNS record in AWS route53.

## Usage

This directory contains Terraform code that ties the sub modules together. Each sub module can also be used individually by going to its sub directory.

To provision the infrastructure with Terraform:

- set the module input variables as described [here](https://www.terraform.io/docs/configuration/variables.html#assigning-values-to-root-module-variables). Variables for the modules are placed in `variables.*.tf` files. Each variable has a description of what it us used for.

- Set AWS credentials according to the Terraform AWS provider [documentation](https://www.terraform.io/docs/providers/aws/index.html).

- check and confirm the changes terraform will make to the infrastructure
  
  ```bash
  terraform plan
  ```
- provision the infrastructure

  ```bash
  terraform apply
  ```
