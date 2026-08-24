# tf-modules release-please secret

The `clouds/github/AJCandfield/tf-modules` unit manages the `RELEASE_PLEASE_TOKEN` Actions secret in the `tf-modules` repository. It is used by release-please to create release pull requests whose required checks can run normally.

Before planning or applying that unit, provide two distinct credentials:

- `GITHUB_TOKEN`: the Terraform GitHub-provider credential, with authority to manage the repository, branch protection, and Actions secrets.
- `RELEASE_PLEASE_TOKEN`: the fine-grained PAT stored in the SOPS-encrypted file. Restrict it to `AJCandfield/tf-modules` and grant Contents and Pull requests read/write permissions.

The release token is encrypted in `clouds/github/AJCandfield/tf-modules/release-please-token.yaml`. Its SOPS policy is in `.sops.yaml`; the private age identity is outside Git at `~/.config/sops/age/keys.txt`, and Mise sets `SOPS_AGE_KEY_FILE` to that location.

Terragrunt decrypts the YAML itself with `sops_decrypt_file` and passes its `RELEASE_PLEASE_TOKEN` value directly to the module. It does not use `get_env` or a plaintext dotenv file.

Run the unit with Mise so Terragrunt can find the local age identity:

```sh
cd clouds/github/AJCandfield/tf-modules
mise exec -- terragrunt plan
mise exec -- terragrunt apply
```

The token is passed through the module's `actions_secrets` input and is retained in the local Terraform state.

Merge the `tf-modules` infrastructure change before applying this unit, then refresh the source with `mise exec -- terragrunt init --source-update`. Until then, the `main` source does not declare the new `actions_secrets` or `required_status_checks` inputs.

## Initial consumer pin

After the initial `github/repository` release is published, resolve its tag to a commit SHA and update all three `github/repository` consumers from `ref=main` to:

```hcl
source = "git::https://github.com/AJCandfield/tf-modules.git//modules/github/repository?ref=<sha>" # github/repository-v0.1.0
```

This first pin is intentionally manual because no SHA-pinned source exists for Renovate to discover yet. The custom Renovate manager then keeps the SHA and tag comment together for later releases; its update PRs are grouped and require review.
