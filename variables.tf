 variable "db_username" {
   description = "The username for the database"
   type        = string
 }

 variable "db_password" {
   description = "The password for the database"
   type        = string
 }

 variable "db_name" {
   description = "The name of the database"
   type        = string
 }

 variable "app_image" {
   description = "The image for the app"
   type        = string
 }

  variable "jwt_secret" {
    description = "The secret for the JWT"
    type        = string
  }