resource "aws_db_instance" "default" {
  allocated_storage      = 20
  engine                 = "postgres"
  engine_version         = "13.4"
  instance_class         = "db.t3.micro"
  # db_name                = "fast-food"
  username               = var.db_username
  password               = var.db_password
  parameter_group_name   = "default.postgres13"
  skip_final_snapshot    = true
  vpc_security_group_ids = var.db_sg_ids
}   

output "db_address" {
  value = aws_db_instance.default.id
}