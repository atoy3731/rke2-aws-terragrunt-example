remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    key            = format("%s/terraform.tfstate", path_relative_to_include())
    region = "us-east-1"
    bucket         = "example-bucket-tf-state"
  }
}