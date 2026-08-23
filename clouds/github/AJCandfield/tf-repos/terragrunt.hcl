include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "git::https://github.com/AJCandfield/tf-modules.git//modules/github/repository?ref=main"
}

inputs = {
  name        = "tf-repos"
  description = "IaC repo for managing my repositories."
  visibility  = "public"
  topics      = ["terraform", "terragrunt", "modules", "infrastructure-as-code"]
}
