resource "aws_cognito_user_pool" "main" {
  name = "user_pool"

  schema {
    attribute_data_type = "String"
    name                = "cpf"
    required            = true
  }
}
