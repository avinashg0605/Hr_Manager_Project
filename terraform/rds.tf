resource "aws_db_subnet_group" "db_subnet" {
  subnet_ids = [
    aws_subnet.private_db_1.id,
    aws_subnet.private_db_2.id
  ]
}

resource "aws_db_instance" "db" {
  allocated_storage = 20
  engine            = "mysql"
  instance_class    = "db.t3.micro"
  username          = "admin"
  password          = "password123"
  db_subnet_group_name = aws_db_subnet_group.db_subnet.name
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  skip_final_snapshot = true
}