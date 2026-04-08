# variable "alb_sg" {}

# variable "alb_config" {
#   description = "ALB configuration"
#   type = list(object({
#     alb_type = string
#     alb_port = number
#   }))
# }

variable "alb_name" { type = string }
variable "alb_type" { type = string  }
variable "subnet_ids" { type = list(string) }
variable "security_group_ids" { type = list(string) }
variable "vpc_id" { type = string }
variable "target_group_port" { type = number  }
variable "target_group_protocol" { type = string  }
variable "listener_port" { type = number  }
variable "listener_protocol" { type = string  }