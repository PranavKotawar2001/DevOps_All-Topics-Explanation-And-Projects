# Monitoring (AWS)

- **Terraform**: `../infra/terraform/cloudwatch.tf` and `monitoring.tf` create log groups and alarms.
- **Operational dashboards**: In the AWS Console → CloudWatch → Dashboards, add widgets for ALB `RequestCount`, `TargetResponseTime`, ECS `CPUUtilization`, RDS `DatabaseConnections`.

Export JSON dashboards from the console and store them here if you want version-controlled dashboards (optional).
