variable "vpc_id" {}
variable "public_subnet_1_id" {}
# variable "alb_sg" {}
variable "public_ec2_sg" {}
# variable "private_ec2_sg" {}

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