variable "alb_sg" {}

variable "alb_type" {
  description = "Alb type"
  default = string
}
variable "alb_port" {
  description = "alb port number"
  default = number
}