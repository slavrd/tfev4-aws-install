# PTFEv4 AWS playground

A repo with packer and terraform configurations which can be used to deploy PTFEv4 in AWS. The project will install PTFEv4 in AWS using external services - AWS S3 and AWS PostgreSQL RDS. 

## Contents

The repository contains:

1. A Packer project to build an AWS AMI which has docker installed and contains static files needed for the PTFEv4 installation. The project is located in the `./packer` folder. Check the [readme](./packer/README.md) for details on what it does and how to use it.

2. A Terraform project to set up PTFEv4 install using external services in AWS. It is located in the `./terraform` folder. The Terraform project assumes that an AMI built with the packer project above is used. 

    The Terraform code is split in several sub-modules. The root module is intended to tie together these sub-modules to bring up the Network, External Services and PTFE instance itself in a single run. Check the [readme](./terraform/README.md) for details on what it does and how to use it.

## TODO

- [x] packer project to create an AWS AMI with docker and static PTFEv4 setup files.
  - [ ] add test for the AMI
- [x] terraform sub-module to create the PTFEv4 instance.
- [x] terraform module to provision a DNS record for PTFE.
- [ ] terraform root module to tie the sub-modules together.
- [ ] terraform sub-module to create the basic network infrastructure.
- [ ] terraform sub-module to external services.
- [ ] add a test for the root terraform module - the effort to add separate tests for each module is not really worthed as they would need additional configuration to be deployed and this configuration would actually be very similar to the rest of the modules.
- [ ] add a load balancer and auto-scaling group according to the reference AWS [architecture](https://www.terraform.io/docs/enterprise/before-installing/reference-architecture/aws.html).