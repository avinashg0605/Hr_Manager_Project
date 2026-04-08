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

module "ec2" {
  source = "./modules/ec2"
  
  vpc_id                = module.vpc.vpc_id
  
  public_subnet_1_id    = module.vpc.public_subnet_1_id
  
  bastion_server_config = var.bastion_server_config
  bastion_sg = module.sg.bastion_sg_id
    
  for_each = var.web_servers

  instance_name      = each.key
  ami_id             = each.value.ami_id
  instance_type      = each.value.instance_type
  key_name           = each.value.key_name
  instance_ebs_volume = each.value.ebs_volume_size
  
  private_subnet_2_id = module.vpc.private_subnet_2_id
  web_ec2_sg = module.sg.web_ec2_sg
  app_ec2_sg = module.sg.app_ec2_sg
  
}
