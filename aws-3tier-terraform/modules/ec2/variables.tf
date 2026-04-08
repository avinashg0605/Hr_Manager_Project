# variable "vpc_id" {}
# variable "public_subnet_1_id" {}
# variable "private_subnet_2_id" {
  
# }
# variable "bastion_sg" {}
# variable "web_ec2_sg" {}
# variable "app_ec2_sg" {}
# variable "key_name" {}
# # variable "rds_ec2_sg" {}

# variable "bastion_server_config" {
#   type = object({
#     instance_type   = string
#     ami_id          = string
#     ebs_volume_size = number
#   })
# }




# variable "instance_name" {
#   type        = string
#   description = "Name of the EC2 instance"
# }

# variable "ami_id" {
#   type        = string
#   description = "AMI ID for the EC2 instance"
# }

# variable "instance_type" {
#   type        = string
#   description = "EC2 instance type"
#   default     = "t2.micro"
# }

# # variable "web_key_name" {
# #   type        = string
# #   description = "Key pair name for SSH access"
# # }

# # variable "subnet_id" {
# #   type        = string
# #   description = "Subnet ID where instance will be launched"
# # }

# # variable "security_group_ids" {
# #   type        = list(string)
# #   description = "Security group IDs"
# # }
# variable "instance_ebs_volume" {
#   type = number
#   description = "Instance EBS Volumes"
# }

variable "instance_name" { type = string }
variable "ami_id" { type = string }
variable "instance_type" { type = string }
variable "subnet_id" { type = string }
variable "security_group_ids" { type = list(string) }
variable "key_name" { type = string }
variable "instance_ebs_volume" { type = number }

variable "target_group_arn" {
  type = string
  default = null
}

variable "instances_map" {
  type = map(any)
  default = {}
}