include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "git::https://github.com/AJCandfield/tf-modules.git//modules/github/repository?ref=8c3ce80c0fa40feb39a3f10c63bcbd952e537dec" # github/repository-v0.2.0
}

inputs = {
  name        = "istio-lab"
  description = "Local Kubernetes and Istio service mesh lab."
  visibility  = "public"
  topics      = ["istio", "k3d", "kubernetes", "service-mesh"]
}
