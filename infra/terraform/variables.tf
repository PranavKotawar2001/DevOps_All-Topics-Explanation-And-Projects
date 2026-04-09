variable "aws_region" {
  type        = string
  description = "AWS region"
  default     = "us-east-1"
}

variable "environment" {
  type        = string
  description = "Environment name (dev, prod)"
  default     = "dev"
}

variable "project_name" {
  type        = string
  default     = "rivermarket"
}

variable "vpc_cidr" {
  type    = string
  default = "10.10.0.0/16"
}

variable "db_username" {
  type    = string
  default = "riverapp"
}

variable "db_name" {
  type    = string
  default = "rivermarket"
}

variable "ecs_desired_count" {
  type    = number
  default = 2
}

variable "codebuild_github_repo" {
  type        = string
  description = "GitHub repo for CodeBuild source (owner/repo), optional"
  default     = ""
}

variable "codebuild_branch" {
  type    = string
  default = "main"
}
