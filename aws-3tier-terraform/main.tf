resource "tls_private_key" "generated" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "key_pair" {
  key_name   = "Hr_manager_bastion"
  public_key = tls_private_key.generated.public_key_openssh
}

resource "local_file" "private_key" {
  content  = tls_private_key.generated.private_key_pem
  filename = "Hr_manager_bastion.pem"
}

module "vpc" {
  source = "./modules/vpc"

  vpc_cidr            = var.vpc_cidr
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr

}
module "sg" {
  source = "./modules/sg"
  vpc_id = module.vpc.vpc_id
}

# Bastion (public subnet)
module "bastion" {
  source = "./modules/ec2"

  instance_name       = "bastion"
  ami_id              = var.bastion.ami_id
  instance_type       = var.bastion.instance_type
  subnet_id           = module.vpc.public_subnet_1_id
  security_group_ids  = [module.sg.bastion_sg_id]
  key_name            = aws_key_pair.key_pair.key_name
  instance_ebs_volume = var.bastion.ebs_volume_size
}

# Web servers (private subnet)
module "web" {
  source = "./modules/ec2"
  for_each = var.web_servers

  instance_name       = each.key
  ami_id              = each.value.ami_id
  instance_type       = each.value.instance_type
  subnet_id           = module.vpc.private_subnet_2_id
  security_group_ids  = [module.sg.web_ec2_sg]
  key_name            = aws_key_pair.key_pair.key_name
  instance_ebs_volume = each.value.instance_ebs_volume

  target_group_arn    = module.alb.target_group_arn
}

# App servers (private subnet)
module "app" {
  source = "./modules/ec2"
  for_each = var.app_servers

  instance_name       = each.key
  ami_id              = each.value.ami_id
  instance_type       = each.value.instance_type
  subnet_id           = module.vpc.private_subnet_2_id
  security_group_ids  = [module.sg.app_ec2_sg]
  key_name            = aws_key_pair.key_pair.key_name
  instance_ebs_volume = each.value.instance_ebs_volume
}

module "alb" {
  source             = "./modules/alb"
  alb_name           = "app-alb"
  alb_type           = "application"
  subnet_ids         = [module.vpc.public_subnet_1_id, module.vpc.public_subnet_2_id]
  security_group_ids = [module.sg.alb_sg_id]
  vpc_id             = module.vpc.vpc_id

  target_group_port     = 80
  target_group_protocol = "HTTP"

  listener_port     = 80
  listener_protocol = "HTTP"
  # target_id = flatten([
  # for web_instance in module.web :
  # web_instance.instance_ids
# ])
}