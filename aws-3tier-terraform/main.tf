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
  
    bastion_server_config = [
    var.bastion_server_config.instance_type,
    var.bastion_server_config.ami_id,
    var.bastion_server_config.ebs_volume_size,
    ]
    bastion_sg = module.sg.bastion_sg_id
    
}