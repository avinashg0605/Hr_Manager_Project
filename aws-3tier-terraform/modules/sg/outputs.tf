output "bastion_sg_id" {
  value = aws_security_group.bastion_sg.id
}

output "alb_sg" {
  value = aws_security_group.alb_sg.id
}

output "public_ec2_sg" {
  value = aws_security_group.public_ec2_sg.id
}
output "private_ec2_sg" {
  value = aws_security_group.private_ec2_sg.id
}

