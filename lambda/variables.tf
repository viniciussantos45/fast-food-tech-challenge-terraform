variable "db_name" {
  description = "Database name"
  type        = string
}

variable "db_username" {
  description = "Database username"
  type        = string
}

variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}

variable "jwt_secret" {
  description = "JWT secret"
  type        = string
  sensitive   = true
}

variable "db_address" {
  description = "Database address"
  type        = string
}

variable "db_sg_ids" {
  type        = list(string)
} 

variable "lambda_sg_ids" {
  type        = list(string)
}