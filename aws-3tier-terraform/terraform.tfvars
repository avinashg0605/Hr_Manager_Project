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
  ami_id = "ami-0abcdef1234567890"
  ebs_volume_size = 10
}

web_ec2 = [
  {
    name              = "web-1"
    ami               = "ami-0abcdef1234567890"
    instance_type     = "t2.micro"
    availability_zone = "us-east-1a"
    key_name          = "my-keypair"
    ebs_volume_size   = 10
    tags = {
      Environment = "dev"
      Role        = "web"
    }
  },
  {
    name              = "web-2"
    ami               = "ami-0abcdef1234567890"
    instance_type     = "t2.micro"
    availability_zone = "us-east-1b"
    key_name          = "my-keypair"
    ebs_volume_size   = 10
    tags = {
      Environment = "dev"
      Role        = "web"
    }
  }
]

api_ec2 = [
  {
    name              = "api-1"
    ami               = "ami-0abcdef1234567890"
    instance_type     = "t2.micro"
    availability_zone = "us-east-1a"
    key_name          = "my-keypair"
    ebs_volume_size   = 10
    tags = {
      Environment = "dev"
      Role        = "api"
    }
  }
]

alb_config = {
  alb_port = 80
  alb_type = "application"
}
asg_config = {
  desired_capacity = 2
  min_size = 2
  max_size = 4
}