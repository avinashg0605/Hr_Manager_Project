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

variable "bastion_server_config" {
  type = object({
    instance_type   = string
    ami_id          = string
    ebs_volume_size = number
  })
}


variable "web_servers" {
  description = "Map of EC2 servers to create"
  type = map(object({
    ami_id             = string
    instance_type      = string
    key_name           = string
    instance_ebs_volume = number
  }))
}

variable "app_servers" {
  description = "Map of EC2 servers to create"
  type = map(object({
    ami_id             = string
    instance_type      = string
    key_name           = string
    instance_ebs_volume = number
  }))
}