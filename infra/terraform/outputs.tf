output "alb_dns_name" {
  value       = aws_lb.main.dns_name
  description = "Public ALB DNS — curl http://<dns>/health"
}

output "ecr_repository_url" {
  value = aws_ecr_repository.api.repository_url
}

output "s3_assets_bucket" {
  value = aws_s3_bucket.assets.bucket
}

output "ecs_cluster_name" {
  value = aws_ecs_cluster.main.name
}

output "rds_endpoint" {
  value       = aws_db_instance.main.address
  description = "PostgreSQL endpoint (private)"
}

output "secretsmanager_database_secret_arn" {
  value       = aws_secretsmanager_secret.db_url.arn
  sensitive   = false
  description = "DATABASE_URL secret for ECS task"
}

output "codebuild_project_name" {
  value       = try(aws_codebuild_project.api[0].name, null)
  description = "CodeBuild project (if GitHub repo configured)"
}
