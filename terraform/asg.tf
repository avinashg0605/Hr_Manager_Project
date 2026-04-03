resource "aws_launch_template" "lt" {
  name_prefix   = "app-lt"
  image_id      = "ami-xxxxxxxx"
  instance_type = "t2.micro"

  network_interfaces {
    security_groups = [aws_security_group.app_sg.id]
  }
}

resource "aws_autoscaling_group" "asg" {
  desired_capacity = 2
  max_size         = 4
  min_size         = 2

  vpc_zone_identifier = [
    aws_subnet.private_app_1.id,
    aws_subnet.private_app_2.id
  ]

  target_group_arns = [aws_lb_target_group.tg.arn]
  launch_template {
    id      = aws_launch_template.lt.id
    version = "$Latest"
  }
}