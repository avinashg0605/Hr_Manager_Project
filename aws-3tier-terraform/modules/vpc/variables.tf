variable "vpc_cidr" {
  description = "Hr manager vpc"
  type = string
}
variable "public_subnet_cidr" {
  description = "Hr manager public subnets"
  type = list(string)
}
variable "private_subnet_cidr" {
  description = "Hr manager private subnets"
  type = list(string)
}



