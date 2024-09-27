# Security Group para a função Lambda
resource "aws_security_group" "lambda_sg" {
  name        = "lambda_sg"
  description = "Security group for Lambda function"
  vpc_id      = aws_vpc.main.id

  # Regras de saída (egress)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Security Group para o RDS
resource "aws_security_group" "db_sg" {
  name        = "db_sg"
  description = "Security group for RDS instance"
  vpc_id      = aws_vpc.main.id

  # Regras de entrada (ingress) permitidas a partir da função Lambda
  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.lambda_sg.id]
    description     = "Allow Lambda access to RDS"
  }
}
