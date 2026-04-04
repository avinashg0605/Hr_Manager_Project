resource "aws_lb" "alb" {
  name               = "app-alb"
  load_balancer_type = var.alb_config.alb_type
  subnets = [
    aws_subnet.public_1.id,
    aws_subnet.public_2.id
  ]
  security_groups = [aws_security_group.alb_sg.id]
}

resource "aws_lb_target_group" "tg" {
  port     = var.alb_config.alb_port
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = var.alb_config.alb_port
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}



