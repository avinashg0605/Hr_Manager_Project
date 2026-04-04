variable "alb_sg" {}

variable "alb_config" {
  description = "ALB configuration"
  type = list(object({
    alb_type = string
    alb_port = number
  }))
}