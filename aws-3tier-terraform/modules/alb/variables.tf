variable "alb_sg" {}

variable "alb_type" {
  description = "Alb type"
  type = string
}
variable "alb_port" {
  description = "alb port number"
  type = number
}