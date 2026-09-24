include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "git::https://github.com/AJCandfield/tf-modules.git//modules/github/repository?ref=aa8e647638a9ae3cb785847176f3faa40a699d21"
}

inputs = {
  name        = "cpp-release-lab"
  description = "Cross-platform C++ and CMake release engineering lab using vcpkg and GitHub Actions."
  visibility  = "public"
  topics      = ["cpp", "cmake", "vcpkg", "github-actions", "release-engineering", "devops"]
}
