
# Locals

locals {
  region            = "us-east-1"
  project_name      = "hr_manager"
  availability_zone_1 = "us-east-1a"
  availability_zone_2 = "us-east-1b"

  common_tags = {
    Project = local.project_name
    Managed = "terraform"
  }

  names = {
    vpc               = "${local.project_name}-vpc"
    igw               = "${local.project_name}-igw"
    public_subnet_1   = "${local.project_name}-${local.availability_zone_1}-public-subnet"
    public_subnet_2   = "${local.project_name}-${local.availability_zone_2}-public-subnet"
    private_subnet_1  = "${local.project_name}-${local.availability_zone_1}-private-subnet"
    private_subnet_2  = "${local.project_name}-${local.availability_zone_2}-private-subnet"
    public_rt         = "${local.project_name}-public-rt"
    private_rt        = "${local.project_name}-private-rt"
    nat               = "${local.project_name}-nat"
  }
}