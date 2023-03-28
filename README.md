# RKE2 AWS Terragrunt Example

This is an example of implementing the [Terraform Modules](https://github.com/rancherfederal/rke2-aws-tf.git). See those docs for more information.

## Getting Started

1. Update `example/terragrunt.hcl` with the respective region/bucket name you want your Terraform/Terragrunt state saved in. NOTE: Terragrunt will create the bucket if it doesn't exist, but it is better practice to pre-create it with encryption enabled.

2. Update `example/common.hcl` with values specific to your environment.

3. Modify/copy `main-workers` and `burst-workers` directories depending on your nodepool requirements.

4. In the `example/controlplane` directory, run `terragrunt plan` and `terragrunt apply`.

5. In each of your workers directory, do the same.