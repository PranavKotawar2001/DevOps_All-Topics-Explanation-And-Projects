# Optional Terraform modules

The reference implementation uses flat `.tf` files under `../terraform/` for readability in class.

For larger engagements, extract:

- `modules/network` — VPC, subnets, NAT, routes
- `modules/datastore` — RDS subnet group, security groups, instance
- `modules/ecs_service` — cluster, task definition, service, ALB wiring

Keep interfaces (`variables.tf` / `outputs.tf`) stable when refactoring.
