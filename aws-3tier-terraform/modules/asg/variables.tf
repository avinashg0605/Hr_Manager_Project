variable "aws_lb_target_group" {}
variable "public_ec2_sg" {}

variable "asg_config" {
  description = "ASG configuration"
  type = object({
    desired_capacity = number
    min_size = number
    max_size = number
  })
}