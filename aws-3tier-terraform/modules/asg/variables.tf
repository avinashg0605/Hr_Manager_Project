variable "aws_lb_target_group" {}
variable "public_ec2_sg" {}

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