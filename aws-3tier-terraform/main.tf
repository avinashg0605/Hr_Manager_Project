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
    var.bastion_server_config.ebs_volume_size
  ]
    # alb_sg = module.sg.alb_sg
    public_ec2_sg = module.sg.public_ec2_sg
    # private_ec2_sg = module.sg.private_ec2_sg
  
#   web_ec2 =[
#       var.web_ec2.name,
#       var.web_ec2.ami,
#       var.web_ec2.instance_type,
#       var.web_ec2.availability_zone,
#       var.web_ec2.key_pair,
#       var.web_ec2.ebs_volume_size,
#       var.web_ec2.tags             
#   ]

#   api_ec2 =[
#       var.api_ec2.name,
#       var.api_ec2.ami,
#       var.api_ec2.instance_type,
#       var.api_ec2.availability_zone,
#       var.api_ec2.key_pair,
#       var.api_ec2.ebs_volume_size,
#       var.api_ec2.tags             
#   ]
}

# module "alb" {
#   source = "./modules/alb"
#   alb_sg = module.sg.alb_sg
#   alb_config = [
#     var.alb_config.alb_type,
#     var.alb_config.alb_port
#     ]
  
# }

# module "asg" {
#   source = "./modules/asg"
#   aws_lb_target_group = module.alb.aws_lb_target_group
#   asg_config = [
#   var.asg_config.desired_capacity,
#   var.asg_config.min_size,
#   var.asg_config.max_size
#   ]

#   public_ec2_sg = module.sg.public_ec2_sg
# }