# ---------------- VPC -----------------
vpc_cidr = "10.0.0.0/16"

public_subnet_cidr = [ 
  "10.0.1.0/24",
  "10.0.2.0/24" 
  ]

private_subnet_cidr = [ 
  "10.0.3.0/24",
  "10.0.4.0/24" 
  ]

bastion_server_config = {
  instance_type = "t2.micro"
  ami_id = "ami-01b14b7ad41e17ba4"
  ebs_volume_size = 10
}

web_servers = {
  web1 = {
    ami_id              = "ami-01b14b7ad41e17ba4"
    instance_type       = "t2.nano"
    # key_name            = "your-keypair-name"
    instance_ebs_volume = 8
  }
  web2 = {
    ami_id              = "ami-01b14b7ad41e17ba4"
    instance_type       = "t2.nano"
    # key_name            = "your-keypair-name"
    instance_ebs_volume = 8
  }
  db1 = {
    ami_id              = "ami-01b14b7ad41e17ba4"
    instance_type       = "t2.nano"
    # key_name            = "your-keypair-name"
    instance_ebs_volume = 8
  }
}