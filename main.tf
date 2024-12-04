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

module "api_gateway" {
  source           = "./api_gateway"
  cluster_endpoint = module.kubernetes.cluster_endpoint
}


module "kubernetes" {
  source     = "./kubernetes"
  subnet_ids = module.networking.subnet_ids
}

# module "secrets" {
#   source      = "./secrets"
#   db_username = var.db_username
#   db_password = var.db_password
# }
