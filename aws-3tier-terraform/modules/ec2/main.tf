# =========================================
# KEY PAIR
# =========================================
resource "tls_private_key" "generated" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "key_pair" {
  key_name   = local.key_pair_name
  public_key = tls_private_key.generated.public_key_openssh
}

resource "local_file" "private_key" {
  content  = tls_private_key.generated.private_key_pem
  filename = "${local.key_pair_name}.pem"
}

#################################
# BASTION EC2 Instance
#################################
resource "aws_instance" "bastion" {
  instance_type = var.bastion_server_config.instance_type
  ami           = var.bastion_server_config.ami_id
  subnet_id     = var.public_subnet_1_id
  security_groups = [aws_security_group.bastion_sg.name]
  key_name = aws_key_pair.key_pair.key_name

  root_block_device {
    volume_size = var.bastion_server_config.ebs_volume_size
  }

  tags = {
    Name = "${local.project_name}-bastion"
  }
}

#################################
# WEB EC2 Instance
#################################
# resource "aws_instance" "web_ec2" {
#   for_each = { for server in var.web_ec2 : server.name => server }

#   ami                    = each.value.ami
#   instance_type          = each.value.instance_type
#   availability_zone      = each.value.availability_zone
#   subnet_id              = each.value.subnet_id
#   key_name               = each.value.key_name
#   vpc_security_group_ids = var.public_ec2_sg

#   root_block_device {
#     volume_size = each.value.ebs_volume_size
#   }

#   tags = merge(
#     each.value.tags,
#     {
#       Name = each.value.name
#     }
#   )
# }

#################################
# API EC2 Instance
#################################

# resource "aws_instance" "api_ec2" {
#   for_each = { for server in var.api_ec2 : server.name => server }

#   ami                    = each.value.ami
#   instance_type          = each.value.instance_type
#   availability_zone      = each.value.availability_zone
#   subnet_id              = each.value.subnet_id
#   key_name               = each.value.key_name
#   vpc_security_group_ids = var.private_ec2_sg
#   root_block_device {
#     volume_size = each.value.ebs_volume_size
#   }

#   tags = merge(
#     each.value.tags,
#     {
#       Name = each.value.name
#     }
#   )
# }