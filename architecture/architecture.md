# RiverMarket — AWS Architecture

```
Internet
   |
   v
[ Application Load Balancer ]  (public subnets, :80)
   |
   v
[ ECS Fargate Service "api" ]  (private subnets, awsvpc, :3000)
   |  env: DATABASE_URL from Secrets Manager
   |  logs: CloudWatch Logs /ecs/rivermarket-*
   |
   v
[ Amazon RDS PostgreSQL ]      (private subnets, :5432)
   ^
   |
[ Amazon S3 bucket ]  <-- task IAM read (assets / future CMS)

Build path:
  GitHub (optional) -> CodeBuild -> Amazon ECR -> ECS task definition image URI
```

NAT Gateway in a public subnet provides outbound internet for private tasks (ECR pulls, etc.). For cost/scale, later add **VPC endpoints** for ECR/S3 and reduce NAT reliance.
