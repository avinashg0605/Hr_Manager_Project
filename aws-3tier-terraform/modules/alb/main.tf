resource "aws_lb" "alb" {
  name               = var.alb_name
  load_balancer_type = var.alb_type
  subnets            = var.subnet_ids
  security_groups    = var.security_group_ids
}

resource "aws_lb_target_group" "tg" {
  name     = "${var.alb_name}-tg"
  port     = var.target_group_port
  protocol = var.target_group_protocol
  vpc_id   = var.vpc_id
  health_check {
    interval            = 30
    path                = "/"
    protocol            = var.target_group_protocol
    matcher             = "200"
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = var.listener_port
  protocol          = var.listener_protocol


  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}

resource "aws_lb_target_group_attachment" "tg_attch" {
  target_group_arn = aws_lb_target_group.tg.arn
  target_id = [ var.target_id ]
  
}