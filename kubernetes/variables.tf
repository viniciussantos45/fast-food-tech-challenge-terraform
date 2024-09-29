variable "app_image" {
  type = string
} 

variable "subnets" {
  type = list(string)
}

variable "db_address" {
  type = string
}