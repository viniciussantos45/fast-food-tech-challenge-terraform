# fast-food-tech-challenge-terraform

Terraform Infrastructure as Code (IaC) for provisioning the complete AWS cloud infrastructure required by the Fast Food Tech Challenge microservices system.

## Objective

The objective of this repository is to automate the provisioning of all AWS resources needed by the fast-food ordering platform, ensuring a reproducible, version-controlled cloud environment. It is part of the broader [FIAP Tech Challenge](https://github.com/viniciussantos45/fast-food-tech-challenge) project.

## Infrastructure Components

| Module | AWS Service |
|---|---|
| Networking | VPC, Subnets, Internet Gateway, Route Tables, Security Groups |
| Kubernetes | EKS (Elastic Kubernetes Service) |
| Database | RDS (PostgreSQL) |
| Authentication | Cognito User Pool |
| API | API Gateway |
| Secrets | AWS Secrets Manager |

## CI/CD

A GitHub Actions workflow (`.github/workflows/deploy.yml`) automates `terraform apply` on push to the main branch.

## Getting Started

```bash
# Configure AWS credentials
aws configure

# Initialize Terraform
terraform init

# Review the plan
terraform plan -var-file=terraform.tfvars

# Apply
terraform apply -var-file=terraform.tfvars
```
