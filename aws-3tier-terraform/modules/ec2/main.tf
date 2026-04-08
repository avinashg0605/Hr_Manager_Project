# #################################
# # BASTION EC2 Instance
# #################################
# resource "aws_instance" "bastion" {
#   instance_type = var.bastion_server_config.instance_type
#   ami           = var.bastion_server_config.ami_id
#   subnet_id     = var.public_subnet_1_id
  
#   vpc_security_group_ids = [ var.bastion_sg ]
#   key_name = var.key_name

#   root_block_device {
#     volume_size = var.bastion_server_config.ebs_volume_size
#   }

#   tags = {
#     Name = "${local.project_name}-bastion"
#   }
# }
# ##################### WEB SERVERS ##############################
# resource "aws_instance" "web_servers" {
#   ami                    = var.ami_id
#   instance_type          = var.instance_type
#   subnet_id     = var.public_subnet_1_id
  
#   vpc_security_group_ids = [ var.web_ec2_sg ]
#   key_name = var.key_name

#   root_block_device {
#     volume_size = var.instance_ebs_volume
#   }

#   tags = {
#     Name = "${local.project_name}-web"
#   }
# }

# ##################### APP SERVERS ##############################
# # resource "aws_instance" "app_servers" {
# #   instance_type = var.instance_type
# #   ami           = var.ami_id
# #   subnet_id     = var.private_subnet_2_id
  
# #   vpc_security_group_ids = [ var.app_ec2_sg ]
# #   key_name = aws_key_pair.key_pair.key_name

# #   root_block_device {
# #     volume_size = var.instance_ebs_volume
# #   }

# #   tags = {
# #     Name = "${local.project_name}-app"
# #   }
# # }

resource "aws_instance" "this" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  vpc_security_group_ids = var.security_group_ids
  key_name = var.key_name

  root_block_device {
    volume_size = var.instance_ebs_volume
  }

  tags = {
    Name = var.instance_name
  }
}