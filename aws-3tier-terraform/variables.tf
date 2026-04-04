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
  description = "Bastion server"
  type = list(object({
    instance_type = string
    ami_id = string
    ebs_volume_size = number
  }))
}

variable "web_ec2" {
  type = list(object({
    name              = string
    ami               = string
    instance_type     = string
    availability_zone = string
    key_name          = string
    ebs_volume_size   = number
    tags              = map(string)
  }))
}

variable "api_ec2" {
  type = list(object({
    name              = string
    ami               = string
    instance_type     = string
    availability_zone = string
    key_name          = string
    ebs_volume_size   = number
    tags              = map(string)
  }))
}

variable "alb_config" {
  description = "ALB configuration"
  type = list(object({
    alb_type = string
    alb_port = number
  }))
}

variable "desired_capacity" {
    description = "ASG desired_capacity"
    type = number
  
}

variable "min_size" {
  description = "ASG min_size"
  type = number
}

variable "max_size" {
  description = "ASG max_size"
  type = number
}