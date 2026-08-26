include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "git::https://github.com/AJCandfield/tf-modules.git//modules/github/repository?ref=8c3ce80c0fa40feb39a3f10c63bcbd952e537dec" # github/repository-v0.2.0
}

inputs = {
  name        = "talos-gcp-infra"
  description = "Talos Kubernetes infrastructure on Google Cloud, managed as a portfolio project."
  visibility  = "public"
  topics      = ["gcp", "kubernetes", "talos", "terraform", "terragrunt", "infrastructure-as-code"]
}
