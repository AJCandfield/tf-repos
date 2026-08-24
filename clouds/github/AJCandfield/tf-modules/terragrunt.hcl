include "root" {
  path = find_in_parent_folders("root.hcl")
}

locals {
  release_please_secrets = get_env("CI", "") == "true" ? {
    RELEASE_PLEASE_TOKEN = "validation-only"
  } : yamldecode(sops_decrypt_file("${get_terragrunt_dir()}/release-please-token.yaml"))
}

terraform {
  source = "git::https://github.com/AJCandfield/tf-modules.git//modules/github/repository?ref=main"
}

inputs = {
  name        = "tf-modules"
  description = "Reusable Terraform modules organized by cloud provider, consumed by live Terragrunt repositories via git sources."
  visibility  = "public"
  topics      = ["terraform", "terragrunt", "modules", "infrastructure-as-code"]

  required_status_checks = ["Conventional PR title"]
  actions_secrets = {
    RELEASE_PLEASE_TOKEN = local.release_please_secrets.RELEASE_PLEASE_TOKEN
  }
}
