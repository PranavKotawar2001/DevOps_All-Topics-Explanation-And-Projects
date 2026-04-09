# RiverMarket AWS — Rollback & failure handling

## ECS deployment rollback

```bash
aws ecs update-service --cluster <cluster> --service api --task-definition <previous-revision-arn> --region <region>
```

Or in the console: ECS → Service → Deployments → roll back to previous deployment.

## Blue/green (future)

- Introduce CodeDeploy for ECS with a second target group, or migrate to **AWS App Runner** / **Lambda** with feature flags.

## Database rollback

- Schema changes: use forward-only migrations in CI; restore from **RDS snapshot** for catastrophic failure.

## Infrastructure rollback

```bash
cd infra/terraform
terraform plan -destroy -target=aws_ecs_service.api   # example: narrow destroy
terraform apply
```

Prefer `terraform state` backups and peer review before destructive changes.
