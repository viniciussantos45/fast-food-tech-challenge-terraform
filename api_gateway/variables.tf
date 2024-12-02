variable "lambda_integration_uri" {
  type = string
}

variable "auth_function_name" {
  type = string
}

variable "aws_cognito_user_pool" {
  description = "The Cognito User Pool"
  type        = any
}
