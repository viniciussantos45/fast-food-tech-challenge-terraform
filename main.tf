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
  region = "us-east-1"
}

module "networking" {
  source = "./networking"
}

module "auth" {
  source = "./auth"
}

module "lambda" {
  source = "./lambda"
  db_name = var.db_name
  db_username = var.db_username
  db_password = var.db_password
  jwt_secret = var.jwt_secret
  db_address = module.database.db_address
  db_sg_ids = module.networking.db_sg_ids
  lambda_sg_ids = module.networking.lambda_sg_ids
}

module "api_gateway" {
  source = "./api_gateway"
  lambda_integration_uri = module.lambda.auth_function_invoke_arn
  auth_function_name = module.lambda.auth_function_name
}  

module "database" {
  source = "./database"
  db_username = var.db_username
  db_password = var.db_password 
  db_sg_ids = module.networking.db_sg_ids
}

module "kubernetes" {
  source = "./kubernetes"
  app_image = var.app_image
  subnets = module.networking.db_subnet_group_ids
  db_address = module.database.db_address
}

module "monitoring" {
  source = "./monitoring"
  auth_function_name = module.lambda.auth_function_name
}

module "secrets" {
  source = "./secrets"
  db_username = var.db_username
  db_password = var.db_password
}
