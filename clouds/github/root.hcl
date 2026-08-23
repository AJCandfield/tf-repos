locals {
  cloud_provider = "github"
  github_owner   = "AJCandfield"

  # Local state is intentionally kept beside each backend-specific leaf.
  state_path = "${get_repo_root()}/clouds/github/${path_relative_to_include()}/terraform.tfstate"
}

remote_state {
  backend = "local"
  generate = {
    path      = "_backend.tf"
    if_exists = "overwrite_terragrunt"
  }

  config = {
    path = local.state_path
  }
}

generate "provider" {
  path      = "_provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "github" {
  owner = "${local.github_owner}"
}
EOF
}

terraform {
  extra_arguments "lock_timeout" {
    commands  = get_terraform_commands_that_need_locking()
    arguments = ["-lock-timeout=1m"]
  }

  extra_arguments "detailed_exitcode" {
    commands  = ["plan"]
    arguments = get_env("CI", "") != "" ? ["-detailed-exitcode"] : []
  }

  before_hook "validate_github_token" {
    commands     = ["plan", "apply"]
    execute      = ["sh", "-c", "test -n \"$GITHUB_TOKEN\" || { echo 'GITHUB_TOKEN is unset'; exit 1; }"]
    run_on_error = false
  }
}
