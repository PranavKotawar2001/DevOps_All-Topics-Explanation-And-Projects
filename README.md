# RiverMarket Regional E-Commerce — AWS DevOps Project

**Powered by CloudBlitz**  
**A Product of Greamio Technologies Private Limited**

**Client delivery context (fictional enterprise engagement):** [PROJECT-INFORMATION.md](PROJECT-INFORMATION.md)

---

**At a glance**

| | |
|--|--|
| **Purpose** | Production-style **AWS** e-commerce API on **ECS Fargate** with **RDS PostgreSQL**, **S3**, **ALB**, **ECR**, **Secrets Manager**, **CloudWatch**, optional **CodeBuild**. |
| **Tech stack** | Terraform (AWS provider), Docker, Node.js (Express), PostgreSQL, AWS CodeBuild (optional) |
| **Self-serve lab** | Start with **[STUDENT-INSTRUCTION.md](STUDENT-INSTRUCTION.md)** — step-by-step without an instructor. |

**High-level steps:** `terraform apply` → seed RDS → build/push **ECR** → `./scripts/deploy.sh` → verify **ALB** `/health`.

---

## 1. Project Title

**RiverMarket Regional E-Commerce — ECS Fargate + RDS PostgreSQL + S3 + Terraform + CodeBuild**

## 2. Client Scenario

- **Industry**: Regional **e-commerce / grocery** marketplace (B2C flash deals).
- **Scale**: **Mid-market** — ~$80M GMV, peak traffic during weekend promos.
- **Geography**: **US East** primary, single-region footprint for this phase.
- **Existing system**: Monolithic PHP on EC2, RDS on a shared cluster, manual AMIs, no container standard, S3 used ad hoc for marketing assets without encryption policy.

## 3. Business Goal

- **Scale** the API tier horizontally during sales.
- **Automate** build → image → deploy with auditable pipelines.
- **Reduce downtime** via health-checked ALB + rolling ECS deployments.
- **Standardize** secrets (DB URL) in Secrets Manager, not flat files.

## 4. Problem Statement

- **Issues**: Vertical-only scaling, snowflake servers, secret sprawl, no infra-as-code review process.
- **Business impact**: Slow releases, higher MTTR, compliance friction (encryption, least privilege).

## 5. Challenges

- **Deployment**: Manual steps; drift between staging and prod.
- **Scaling**: EC2 capacity planning lags traffic; connection storms to DB.
- **Security**: Broad IAM, open SG patterns in legacy.
- **Cost**: Idle oversized instances; NAT Gateway cost must be justified.

## 6. Solution Architecture (DETAILED)

**Flow**: Internet → **Application Load Balancer** (public subnets) → **ECS Fargate** tasks (private subnets, port 3000) → **RDS PostgreSQL** (private subnets). Static/marketing assets in **S3** (SSE-S3, block public access). **Secrets Manager** holds `DATABASE_URL`. **CloudWatch** collects ECS logs and alarms on ALB 5xx / ECS CPU. **ECR** stores images. **CodeBuild** (optional) builds from GitHub and pushes to ECR.

**Services & purpose**

| Service | Purpose |
|--------|---------|
| VPC + IGW + NAT | Isolated subnets; outbound for pulls from ECR |
| ALB + target group | HTTP entry, health checks to `/health` |
| ECS Fargate | Stateless API containers |
| RDS PostgreSQL | Transactional product catalog |
| S3 | Encrypted object storage for assets |
| Secrets Manager | `DATABASE_URL` for tasks |
| IAM | Task execution + task role (S3 read) |
| CloudWatch | Logs + alarms |
| ECR | Container registry |
| CodeBuild | CI build/push (optional GitHub) |

See `architecture/architecture.md` for the diagram narrative.

## 7. Implementation (Step-by-step)

| Phase | Steps |
|-------|--------|
| Account | Create AWS account / landing zone; enable billing alarms. |
| IAM | Use least-privilege roles for Terraform operator; separate CI role for CodeBuild. |
| Networking | `terraform apply` creates VPC, public/private subnets, NAT, routes. |
| Compute | ECS cluster + Fargate service behind ALB. |
| Database | RDS in private subnets; credentials via Secrets Manager. |
| Storage | S3 bucket with encryption + public access block. |
| CI/CD | Optional: set `codebuild_github_repo`, apply, run build. |
| App deploy | `./scripts/deploy.sh` pushes `:latest` and forces ECS rollout. |
| Monitoring | CloudWatch log groups + alarms (Terraform). |
| Rollback | Prior task definition revision or `terraform` state rollback — see `docs/rollback.md`. |

## 8. Directory Structure

See repository tree: `infra/terraform/`, `app/`, `docker/`, `cicd/`, `monitoring/`, `scripts/`, `docs/`, `env/`.

## 9. Required File Contents

- **App**: Node.js Express — `GET /health`, `GET /api/products` (PostgreSQL).
- **Docker**: `docker/Dockerfile` (non-root user, health check).
- **Terraform**: `infra/terraform/*.tf` — VPC, RDS, ECS, ALB, S3, ECR, IAM, Secrets, CloudWatch, CodeBuild (optional).
- **CI/CD**: `cicd/buildspec.yml` for CodeBuild.
- **Monitoring**: `infra/terraform/monitoring.tf` + `monitoring/README.md`.

## 10. Cloud-Specific Requirements (AWS)

- **ECS Fargate**, **S3**, **RDS**, **IAM**, **CloudWatch**, **Terraform**, **CodeBuild** (optional GitHub source).

## 11. README — Commands & Verification

```bash
cd infra/terraform && terraform init && terraform apply
# After apply — push image & rollout
cd ../.. && ./scripts/deploy.sh rivermarket-dev api
terraform output alb_dns_name
curl -s http://$(terraform output -raw alb_dns_name)/health
```

**Expected**: JSON `status: ok` from `/health`; `/api/products` returns data after SQL migration.

**Cost (approx., single dev region, rough)**:

- NAT Gateway ~$32/mo + data
- RDS `db.t4g.micro` ~$15–25/mo + storage
- ECS Fargate 2×0.5 vCPU tasks ~$30–50/mo depending on uptime
- ALB ~$20/mo + LCU
- **Total ballpark**: **$120–200/mo** (dev); prod multi-AZ + backups higher.

**Cleanup**:

```bash
cd infra/terraform
terraform destroy
```

Empty ECR manually if needed; verify RDS snapshot policy before destroy in prod.

## 12. Demo Walkthrough

- **Live**: Show Terraform plan → apply snippet; ECR image push; ECS deployment; CloudWatch logs; ALB health.
- **Talking points**: Private RDS, secrets injection, least-privilege SGs, NAT for egress only.
- **Interview Q&A**: *Why Fargate vs EC2?* Ops offload & bin packing; *Why Secrets Manager?* Rotation & audit; *ALB vs NLB?* HTTP routing & health checks for this API.

## 13. Learning Outcome

- **Skills**: AWS networking, ECS operational model, RDS + secrets, IaC review, CI to registry.
- **Roles**: Cloud DevOps, platform engineer, solutions architect (delivery).
- **Relevance**: Matches **real retail** pipelines: regulated change control + observable releases.

## License

This project is developed and owned by **CloudBlitz**, a product of **Greamio Technologies Private Limited**.

Unauthorized copying, distribution, or commercial usage of this project, in whole or in part, is strictly prohibited without prior written permission.

This project is intended strictly for educational and training purposes under CloudBlitz programs.

© 2026 Greamio Technologies Private Limited. All rights reserved.
