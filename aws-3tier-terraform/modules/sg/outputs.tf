output "bastion_sg_id" {
  value = aws_security_group.bastion_sg.id
}

output "alb_sg_id" {
  value = aws_security_group.alb_sg.id
}

output "web_ec2_sg" {
  value = aws_security_group.web_ec2_sg.id
}
output "app_ec2_sg" {
  value = aws_security_group.app_ec2_sg.id
}

