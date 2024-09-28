resource "aws_cloudwatch_log_group" "lambda_log_group" {
  name              = "/aws/lambda/${var.auth_function_name}"
  retention_in_days = 14
}
