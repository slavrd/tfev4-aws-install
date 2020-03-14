terraform {
  backend "remote" {
    organization = "srd-tfe-managed"
    workspaces {
      name = "ptfev4-aws-play-net-dev"
    }
  }
}