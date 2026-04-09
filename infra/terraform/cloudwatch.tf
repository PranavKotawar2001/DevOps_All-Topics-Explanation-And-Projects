resource "aws_cloudwatch_log_group" "ecs_api" {
  name              = "/ecs/${var.project_name}-${var.environment}/api"
  retention_in_days = var.environment == "prod" ? 30 : 7

  tags = {
    Name = "${var.project_name}-ecs-api-logs"
  }
}
