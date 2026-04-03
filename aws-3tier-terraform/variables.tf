variable "vpc_cidr" {
  description = "Hr manager vpc"
  type = string
}
variable "public_subnet_cidr" {
  description = "Hr manager public subnets"
  type = list(string)
}
variable "private_subnet_cidr" {
  description = "Hr manager private subnets"
  type = list(string)
}

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
