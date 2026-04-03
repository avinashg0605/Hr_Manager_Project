variable "vpc_id" {}
variable "public_subnet_id" {}

variable "bastion_ec2_type" {
  description = "bastion server"
  type = string
}

variable "bastion_ec2_image" {
  description = "bastion ec2 image id"
  type = string
}

variable "bastion_ebs_volume" {
  description = "bastion ec2 ebd volume"
  type = number
}
