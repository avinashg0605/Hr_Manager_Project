module "vpc" {
  source = "./modules/vpc"

  vpc_cidr            = var.vpc_cidr
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr

}
module "ec2" {
  source = "./modules/ec2"
  vpc_id           = module.vpc.vpc_id
  public_subnet_id = module.vpc.public_subnet_1_id
  bastion_ec2_type = var.bastion_ec2_type
  bastion_ec2_image = var.bastion_ec2_image
  bastion_ebs_volume = var.bastion_ebs_volume
}