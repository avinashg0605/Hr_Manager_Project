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

# variable "web_ec2" {
#   type = list(object({
#     name              = string
#     ami               = string
#     instance_type     = string
#     availability_zone = string
#     key_name          = string
#     ebs_volume_size   = number
#     tags              = map(string)
#   }))
# }

# variable "api_ec2" {
#   type = list(object({
#     name              = string
#     ami               = string
#     instance_type     = string
#     availability_zone = string
#     key_name          = string
#     ebs_volume_size   = number
#     tags              = map(string)
#   }))
# }

variable "alb_config" {
  description = "ALB configuration"
  type = object({
    alb_type = string
    alb_port = number
  })
}

variable "asg_config" {
  description = "ASG configuration"
  type = object({
    desired_capacity = number
    min_size = number
    max_size = number
  })
}