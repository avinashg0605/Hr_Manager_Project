output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_1_id" {
  value = module.vpc.public_subnet_1_id
}

output "public_subnet_2_id" {
  value = module.vpc.public_subnet_2_id
}

# output "ec2_instance_ids" {
#   value = { for name, mod in module.ec2_instances : name => mod.instance_id }
# }

# output "ec2_public_ips" {
#   value = { for name, mod in module.ec2_instances : name => mod.public_ip }
# }

output "web_instance_ids_map" {
  value = {
    for key, web_instance in module.web :
    key => web_instance.instance_ids
  }
}