# RiverMarket AWS — Troubleshooting

## ECS tasks fail with CannotPullContainerError

- Push `:latest` to the correct ECR URL from `terraform output ecr_repository_url`.
- Confirm private subnets reach ECR via **NAT Gateway** (route table) or **VPC endpoints** for ECR.

## 503 from ALB / unhealthy targets

- Check `/health` returns 200 inside the task.
- Confirm security groups: ALB → ECS on 3000, ECS → RDS on 5432.
- Run `aws ecs describe-tasks` and inspect stopped reason.

## Database connection errors in app logs

- Run `001_init.sql` so `products` exists.
- Verify `DATABASE_URL` secret matches RDS endpoint and password (Secrets Manager).

## Terraform RDS engine version error

- Adjust `engine_version` in `infra/terraform/rds.tf` to a version available in your region (RDS → Create → Engine versions).

## CodeBuild cannot clone GitHub

- Authorize OAuth / CodeStar connection for the organization/repository.
