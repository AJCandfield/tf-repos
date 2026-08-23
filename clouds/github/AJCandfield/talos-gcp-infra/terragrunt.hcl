include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "git::https://github.com/AJCandfield/tf-modules.git//modules/github/repository?ref=main"
}

inputs = {
  name        = "talos-gcp-infra"
  description = "Talos Kubernetes infrastructure on Google Cloud, managed as a portfolio project."
  visibility  = "public"
  topics      = ["gcp", "kubernetes", "talos", "terraform", "terragrunt", "infrastructure-as-code"]
}
