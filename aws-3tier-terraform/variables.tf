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


variable "bastion" {
  type = object({
    ami_id          = string
    instance_type   = string
    ebs_volume_size = number
  })
}

variable "web_servers" {
  type = map(object({
    ami_id            = string
    instance_type     = string
    instance_ebs_volume = number
  }))
}

variable "app_servers" {
  type = map(object({
    ami_id            = string
    instance_type     = string
    instance_ebs_volume = number
  }))
}

########################################
# ALB Variables
########################################
variable "alb_config" {
  type = object({
    alb_name   = string
    alb_type   = string
    alb_port   = number
  })
  description = "Configuration for the Application Load Balancer"
}