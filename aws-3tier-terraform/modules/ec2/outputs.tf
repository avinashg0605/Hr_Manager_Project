output "bastion_instance_id" {
  description = "ID of the Bastion host instance"
  value       = aws_instance.bastion.id
}

output "bastion_public_ip" {
  description = "Public IP of the Bastion host"
  value       = aws_instance.bastion.public_ip
}

output "bastion_private_ip" {
  description = "Private IP of the Bastion host"
  value       = aws_instance.bastion.private_ip
}

# output "bastion_sg_id" {
#   description = "Security Group ID attached to Bastion"
#   value       = aws_security_group.bastion_sg.id
# }
