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
    ami_id             = "ami-12345678"
    instance_type      = "t3.micro"
    key_name           = "mykey"
    subnet_id          = "subnet-11111111"
    security_group_ids = ["sg-11111111"]
  }
  web2 = {
    ami_id             = "ami-12345678"
    instance_type      = "t3.micro"
    key_name           = "mykey"
    subnet_id          = "subnet-11111112"
    security_group_ids = ["sg-11111111"]
  }
  db1 = {
    ami_id             = "ami-87654321"
    instance_type      = "t3.medium"
    key_name           = "mykey"
    subnet_id          = "subnet-11111113"
    security_group_ids = ["sg-22222222"]
  }
}