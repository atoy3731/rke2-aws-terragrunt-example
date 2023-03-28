locals {
  common  = read_terragrunt_config(find_in_parent_folders("common.hcl"))
}

terraform {
  source = "git::https://github.com/rancherfederal/rke2-aws-tf.git//?ref=v2.1.0"
}

include {
    path = find_in_parent_folders()
}

inputs = {
  cluster_name    = "example-cluster"
  
  vpc_id               = local.common.locals.vpc_id
  subnets              = local.common.locals.subnets
  rke2_version         = local.common.locals.rke2_version
  ami                  = local.common.locals.ami
  servers              = local.common.locals.servers
  instance_type        = local.common.locals.server_instance_type

  # If set to "true", will create/attach IAM roles for AWS cloud provider (ELBs, EBS, etc.)
  enable_ccm = false

  # RKE2 Config File Settings
  rke2_config =  <<EOF
node-label:
  - "category=controlplane"
node-taint:
  - "CriticalAddonsOnly=true:NoExecute"
EOF

  pre_userdata = <<EOF
echo "Anything to run before RKE2 install runs here."
EOF

  post_userdata = <<EOF
echo "Anything to run after RKE2 install runs here."
EOF

  block_device_mappings = {
    "device_name" = "/dev/xvda"
    "size"      = 100
    "encrypted" = true
  }

  tags = {}
}