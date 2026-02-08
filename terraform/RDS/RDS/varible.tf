
variable "allocated_storage" {
  description = "Minimum allocation storage"
  default = 10
  type = number
}

variable "max_allocated_storage" {
  description = "maximum allocation storage"
  default = 20
  type = number
}

variable "instance_class" {
  description = "instance type"
  default = "db.t3.micro"
  type = string
}

variable "username" {
  description = "username for database"
  default = "admin"
}

variable "password" {
  description = "password for database"
  default = "admin"
}