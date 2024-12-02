terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }

  required_version = ">= 0.12"
}

provider "aws" {
  region  = "us-east-1"
  profile = "default"
  # assume_role {
  #   role_arn     = "arn:aws:iam::857454287964:role/LabRole"
  #   session_name = "LabInstanceProfile"
  # }
}

module "networking" {
  source = "./networking"
}

# module "api_gateway" {
#   source                 = "./api_gateway"
#   auth_function_name     = module.lambda.auth_function_name
#   lambda_integration_uri = module.lambda.auth_function_invoke_arn
#   aws_cognito_user_pool  = module.auth.aws_cognito_user_pool
# }


module "kubernetes" {
  source     = "./kubernetes"
  subnet_ids = module.networking.subnet_ids
}

# module "secrets" {
#   source      = "./secrets"
#   db_username = var.db_username
#   db_password = var.db_password
# }
