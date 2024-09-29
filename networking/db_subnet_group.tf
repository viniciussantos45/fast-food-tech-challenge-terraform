resource "aws_db_subnet_group" "main" {
  name       = "main"
  subnet_ids = [aws_subnet.public-az1.id, aws_subnet.public-az2.id]
}

output "db_subnet_group_ids" {
  value = aws_db_subnet_group.main.subnet_ids
}
