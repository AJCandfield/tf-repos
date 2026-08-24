include "root" {
  path = find_in_parent_folders("root.hcl")
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
    RELEASE_PLEASE_TOKEN = get_env("CI", "") == "true" ? "mock" : yamldecode(sops_decrypt_file("${get_terragrunt_dir()}/release-please-token.secret.yaml")).RELEASE_PLEASE_TOKEN
  }
}
