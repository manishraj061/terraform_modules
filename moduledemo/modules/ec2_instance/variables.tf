variable "region" {
  description = "region"
}
variable "amis" {
  type = map
}
variable "name" {}
variable "instance_type" {}
variable "availability_zone" {
        description = "Zone in which instance exist"
}
variable "key_name" {}
locals {
  Environment = "Development"
  Owner = "Devops Team"
}
locals {
  # Common tags to be assigned to all resources
  common_tags = {
    Environment = local.Environment
    Owner   = local.Owner
  }
}
