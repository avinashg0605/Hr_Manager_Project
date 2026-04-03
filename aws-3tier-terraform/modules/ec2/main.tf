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
# Security Group for Bastion
#################################
resource "aws_security_group" "bastion_sg" {
  name        = "${local.project_name}-public-sg"
  description = "Allow SSH and HTTP"
  vpc_id      = aws_vpc.main.id

  # SSH from your IP
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["YOUR_IP/32"]  # set your IP in variables.tf or tfvars
  }

  # HTTP from anywhere
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # All outbound allowed
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${local.project_name}-public-sg"
  }
}

#################################
# Bastion EC2 Instance
#################################
resource "aws_instance" "bastion" {
  instance_type = var.bastion_ec2_type
  ami           = var.bastion_ec2_image
  subnet_id     = aws_subnet.public_subnet_1.id  # place it in public subnet
  security_groups = [aws_security_group.bastion_sg.name]

  root_block_device {
    volume_size = var.bastion_ebs_volume
  }

  tags = {
    Name = "${local.project_name}-bastion"
  }
}