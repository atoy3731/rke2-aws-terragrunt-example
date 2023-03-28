locals {
  common  = read_terragrunt_config(find_in_parent_folders("common.hcl"))
}

terraform {
  source = "git::https://github.com/rancherfederal/rke2-aws-tf.git//modules/agent-nodepool?ref=v2.1.0"
}

dependency "controlplane" {
  config_path = "../controlplane"
  mock_outputs = {
    cluster_data = {
      name       = "mock"
      server_url = "mock"
      cluster_sg = "mock"
      token = {
        bucket          = "mock"
        bucket_arn      = "mock"
        object          = "mock"
        policy_document = <<-EOT
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Sid": "",
          "Effect": "Allow",
          "Action": "s3:GetObject",
          "Resource": "arn:aws-us-gov:s3:::mock/mock"
        }
      ]
    }
    EOT
      }
    }  
  }
}

include {
    path = find_in_parent_folders()
}

inputs = {
  name    = "burst-worker"

  vpc_id               = local.common.locals.vpc_id
  subnets              = local.common.locals.subnets
  rke2_version         = local.common.locals.rke2_version
  ami                  = local.common.locals.ami
  instance_type        = local.common.locals.server_instance_type

  # If set to "true", will create/attach IAM roles for AWS cloud provider (ELBs, EBS, etc.)
  enable_ccm = false

  # If set to "true", will create/attach IAM roles for AWS cluster-autoscaler (EC2, ASG, etc.)
  enable_autoscaler = false

  rke2_config = <<EOF
node-label:
  - "category=burst"
node-taint:
  - "category=burst:NoSchedule"
EOF

  pre_userdata = <<EOF
echo "Anything to run before RKE2 install runs here."
EOF

  post_userdata = <<EOF
echo "Anything to run after RKE2 install runs here."
EOF

  instance_type = local.common.locals.burst_worker_instance_type
  
  asg = {
    min = local.common.locals.burst_worker_min
    max = local.common.locals.burst_worker_max
    desired = local.common.locals.burst_worker_desired
  }

  # If you want to use spot instances
  spot = true

  block_device_mappings = {
    "device_name" = "/dev/xvda"
    "size"      = 100
    "encrypted" = true
  }

  # This tag is necessary for cluster-autoscaler (if you want your ASGs to scale entirely down to 0)
  tags = {
    "k8s.io/cluster-autoscaler/node-template/label/category": "burst"
  }

  cluster_data = dependency.controlplane.outputs.cluster_data
}