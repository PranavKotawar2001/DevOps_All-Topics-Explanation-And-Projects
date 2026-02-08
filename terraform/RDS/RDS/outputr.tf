output "rds_endpoint" {
  description = "RDS database endpoint"
  value       = aws_db_instance.default.endpoint
}
