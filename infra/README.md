# Infrastructure (AWS)

Terraform source of truth: **`infra/terraform/`**.

- Files: `versions.tf`, `variables.tf`, `vpc.tf`, `rds.tf`, `ecs.tf`, `alb.tf`, `s3.tf`, `ecr.tf`, `iam.tf`, `secrets.tf`, `cloudwatch.tf`, `monitoring.tf`, `cicd.tf`, `outputs.tf`
- Optional modules: `modules/README.md`

```bash
cd infra/terraform
terraform init
terraform apply
```
