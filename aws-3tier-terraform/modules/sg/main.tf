#################################
# Bastion Security Group
#################################
resource "aws_security_group" "bastion_sg" {
  name        = "${local.project_name}-bastion-sg"
  description = "Allow SSH"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH from your IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]   # e.g., "1.2.3.4/32"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${local.project_name}-bastion-sg"
  }
}

#################################
# ALB Security Group
#################################
resource "aws_security_group" "alb_sg" {
  name        = "${local.project_name}-alb-sg"
  description = "Allow HTTP from internet"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTP from internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${local.project_name}-alb-sg"
  }
}

#################################
# Public EC2 Security Group
#################################
resource "aws_security_group" "web_ec2_sg" {
  name        = "${local.project_name}-public-ec2-sg"
  description = "Allow traffic from ALB"
  vpc_id      = var.vpc_id

  ingress {
    description     = "HTTP from ALB"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  # Optional: allow SSH from bastion
  ingress {
    description     = "SSH from Bastion"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${local.project_name}-public-ec2-sg"
  }
}

#################################
# Private EC2 Security Group
#################################
resource "aws_security_group" "app_ec2_sg" {
  name        = "${local.project_name}-private-ec2-sg"
  description = "Allow app traffic from public EC2"
  vpc_id      = var.vpc_id

  ingress {
    description     = "App traffic from public EC2"
    from_port       = 3000
    to_port         = 3000
    protocol        = "tcp"
    security_groups = [aws_security_group.web_ec2_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${local.project_name}-private-ec2-sg"
  }
}

#################################
# RDS Security Group
#################################
resource "aws_security_group" "rds_sg" {
  name        = "${local.project_name}-rds-sg"
  description = "Allow MySQL from private EC2"
  vpc_id      = var.vpc_id

  ingress {
    description     = "MySQL from private EC2"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.app_ec2_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${local.project_name}-rds-sg"
  }
}