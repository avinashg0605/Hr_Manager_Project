variable "vpc_id" {}
variable "public_subnet_1_id" {}
variable "bastion_sg" {}

variable "bastion_server_config" {
  type = object({
    instance_type   = string
    ami_id          = string
    ebs_volume_size = number
  })
}
