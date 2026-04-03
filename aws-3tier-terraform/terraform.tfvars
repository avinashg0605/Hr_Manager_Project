# ---------------- VPC -----------------
vpc_cidr = "10.0.0.0/16"

public_subnet_cidr = [ "10.0.1.0/24","10.0.2.0/24" ]

private_subnet_cidr = [ "10.0.3.0/24","10.0.4.0/24" ]

bastion_ec2_type = "c7i-flex.large"
bastion_ec2_image = "ami-01b14b7ad41e17ba4"
bastion_ebs_volume = 20