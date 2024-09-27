resource "aws_lambda_function" "auth_function" {
  function_name = "auth_function"
  handler       = "index.handler"
  runtime       = "nodejs18.x"
  role          = aws_iam_role.lambda_exec.arn
  filename      = "lambda_auth_postgres.zip"
  publish       = true

  environment {
    variables = {
      DB_HOST     = aws_db_instance.default.address
      DB_NAME     = aws_db_instance.default.db_name
      DB_USER     = aws_db_instance.default.username
      DB_PASSWORD = var.db_password
      JWT_SECRET  = var.jwt_secret
    }
  }

  vpc_config {
    subnet_ids         = aws_db_subnet_group.main.subnet_ids
    security_group_ids = aws_security_group.lambda_sg.id
  }

  depends_on = [aws_iam_role_policy_attachment.lambda_basic_execution]
}

resource "aws_iam_role" "lambda_exec" {
  name = "lambda_exec_role"

  assume_role_policy = jsonencode({
    Version : "2012-10-17",
    Statement : [{
      Action : "sts:AssumeRole",
      Effect : "Allow",
      Principal : {
        Service : "lambda.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}
