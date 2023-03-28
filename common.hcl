locals {
  # Example AWS Metadata
  vpc_id  = "vpc-01234567890123456"
  subnets = ["subnet-01234567890123456", "subnet-987654321098765"]
  ami     = "ami-01234567890123456"

  # RKE2 version to install
  rke2_version = "v1.24.11+rke2r1"

  # Controlplane Instance Type
  server_instance_type = "m5.large"

  # Public SSH Key Example
  ssh_public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDKxecqvqM0G60PHYy6aSjGCPez0H6yohCQksN8vRm/Fgt0UZHZrR+LGzhN8V3T5mmEmZzc1mP0/35+8aQKtVnRjACMlW/hH2nftO8hLU1Un4YVdvO7Xr2h7mx64W6LfAQ1fHYQnPpD8P3o3U5H8nzSGhu1PCMvhMsoc8NIoTMy3o80llv/sxDNtohnis/BMyD1k2i93OVnQMPGjBEniQ1/rSPGASFaUARTuG0dv+umpTig7wxeZawgpnk4+3DlPPg0BtdY57nS3xydd3u8Dh3I23RMmehAByw1ZGeV3jIccz4HEF7umW9uTuKIu+znpNEWoyyZ+Z2cOG3l0VizAQbRw/YGR/stANDUN8kZXV0UlrLWwVjPVKLJUKZI75cz+oYjwwMAjEgkC0nB9Mo7YIgFA8yRjzDPcr8e8GQnj1bAWKWvZ3L5BGGuLsk0PAyWY29Atp463qAlcvkeoTwXptgCE0Gl5u17gavSHhetd8eZJxiFDDDEFeuwuN4tRw460R0= example-key"

  # Other nodepool instance types
  main_worker_instance_type = "m5.2xlarge"
  burst_worker_instance_type = "m5.xlarge"

  # Number of controlplanes
  servers = 5
  
  # Main nodepool AWS ASG node counts
  main_worker_min = 8
  main_worker_desired = 8
  main_worker_max = 9

  # Burst worker (scales to 0, so desired is 0)
  burst_worker_min = 0
  burst_worker_desired = 0
  burst_worker_max = 10

}
