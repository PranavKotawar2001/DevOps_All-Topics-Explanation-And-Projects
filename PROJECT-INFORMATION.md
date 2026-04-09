# PROJECT-INFORMATION.md — RiverMarket Regional E-Commerce (AWS)

**Powered by CloudBlitz** · A Product of **Greamio Technologies Private Limited**

---

## 1. Client Overview

**RiverMarket Foods, Inc.** is a fictional mid-market regional grocery and flash-deal e-commerce company headquartered in **Charlotte, North Carolina**. Founded in 2011, they serve **US East Coast** shoppers through a customer-facing storefront and a set of partner APIs used by inventory systems at their three fulfillment hubs in North Carolina, Virginia, and Georgia.

Their business model is a marketplace: independent food brands list products, RiverMarket charges a take rate on every sale (typically 12–18%), collects delivery fees, and earns promotional placement revenue from brands that want featured visibility during weekend flash sales. Annual GMV sits around **$80 million**, with roughly 180 full-time employees — mostly in logistics, merchandising, and customer service. The engineering team is ten people.

---

## 2. Business Scenario

### The World Before This Engagement

Walk into RiverMarket's engineering department in early 2024 and you'd find a team that was proud of what they'd built — but stretched dangerously thin. Their backend was a PHP monolith running on two EC2 instances, deployed manually by the senior backend engineer, **Priya**, every Thursday night. Priya had been at RiverMarket for four years. She was the only person who knew the full deployment sequence by heart.

The database was a self-managed PostgreSQL server on a `t3.medium` EC2 in the same subnet as the application. The DB credentials? Hardcoded in a PHP config file committed to a private GitHub repo, alongside the AWS access keys used for S3 uploads. There was no secrets manager. There was no container. There was no autoscaling.

For 46 weeks a year, this worked. But RiverMarket ran **flash sales every Friday and Saturday night** — marketing campaigns where a brand might be featured with 40% off for 4 hours. During these windows, traffic spiked 8x. And twice in 2023, the site collapsed under load during flash sales, serving 502 errors to thousands of customers.

---

## 3. Problem Statement

### The Flash Sale That Broke Everything

The incident that changed everything happened on **Black Friday 2023**. RiverMarket had partnered with a regional organic food brand for a large campaign — their biggest promotional event ever. The marketing team had sent emails to 340,000 subscribers. At 7:00 PM, the campaign went live.

By 7:11 PM, the site was down.

The PHP-FPM workers exhausted memory under the traffic spike. The database ran out of connections. The EC2 instances were already at 100% CPU. Priya got a call from her manager at 7:15 PM, pulled up her laptop, and spent the next 3.5 hours manually restarting services, tweaking PHP worker counts, and watching logs scroll. Orders were lost. The food brand partner sent a formal complaint. RiverMarket's Head of Engineering, **Daniel Rivera**, wrote an incident report that sat on the CEO's desk the next morning.

The root causes were undeniable:
- **No horizontal scaling** — the PHP app couldn't add capacity; it could only crash
- **No managed database** — connection exhaustion on a self-managed instance with no automatic recovery
- **No secrets management** — credentials in code meant the team was one leaked repo away from a security incident
- **No CI/CD** — every deployment was a manual, high-stress operation owned by one person
- **No observability** — when the site went down, the team had no dashboards, no alarms, nothing

---

## 4. Why Client Came to Us (CloudBlitz)

Daniel Rivera reached out to CloudBlitz in January 2024. His email was direct: *"We need to fix our platform before the next big sale. We can't keep operating this way."*

Three specific drivers brought RiverMarket to us:

1. **The Black Friday incident** had shaken leadership confidence. The CEO wanted a 30-day action plan.
2. **A new VP of Partnerships** had been hired with experience at a larger e-commerce company — she immediately flagged that their infrastructure practices would disqualify them from enterprise partnerships that required SOC 2-adjacent security standards.
3. **Priya herself** had given Daniel a frank assessment: she was burning out managing deployments manually while also doing feature development. She needed tooling that would let the team operate without her being the single point of failure.

CloudBlitz's response: containerise the API, move to **ECS Fargate** for elastic scaling, use **RDS PostgreSQL** as a managed database, adopt **Secrets Manager** for credential hygiene, and establish a deployment workflow that any engineer on the team could run.

---

## 5. Our Solution Approach

The CloudBlitz team began with a **two-week assessment sprint**. We inventoried every EC2 instance, every IAM user, every hard-coded secret (there were eleven — we found them with a grep). We mapped the traffic patterns from CloudWatch logs (they existed, but no one had been reading them). We documented the current deployment procedure by sitting with Priya for a full day.

The architecture recommendation was:

- **ECS Fargate** for the Node.js API (containerised rewrite — the PHP monolith was too entangled to containerise directly in the engagement timeframe)
- **Application Load Balancer** for traffic distribution and health-checked routing
- **RDS PostgreSQL** with Multi-AZ configuration for production (lab uses single-AZ for cost)
- **Secrets Manager** to inject `DATABASE_URL` into ECS task definitions at runtime — no credentials in code
- **ECR** for container image storage
- **S3** for static marketing assets, with encryption and lifecycle policies
- **CloudWatch** with structured log groups and alarms on ALB 5xx rates and ECS CPU

All infrastructure is provisioned via **Terraform** — reproducible, version-controlled, peer-reviewable.

---

## 6. Proposed Architecture

```
Internet traffic (customers + partner APIs)
             │
             ▼
  Application Load Balancer (public subnets, us-east-1)
    Target groups with health check → /health
             │
             ▼
  ECS Fargate Tasks — Node.js API (private subnets)
    - 2 tasks minimum; scales to 10 based on CPU/request count
    - DATABASE_URL injected from Secrets Manager at startup
    - Container images pulled from ECR
             │
             ▼
  RDS PostgreSQL (private subnets, Multi-AZ in prod)
    - Managed backups (7-day retention)
    - Security Group: only ECS task SG can connect on port 5432
             │
             ▼
  S3 — static assets and marketing materials
    - Server-side encryption (SSE-S3)
    - Public-read bucket policy only for approved asset prefixes

Secrets Manager — stores DATABASE_URL
CloudWatch — logs (/ecs/rivermarket-*), alarms, dashboards
ECR — container image registry
```

---

## 7. Project Execution Flow

**SDLC: Agile / Scrum** — 2-week sprints.

**Sprint 1 — Infrastructure Foundation**
The team stood up the Terraform modules for VPC, ECS cluster, RDS, and Secrets Manager. Priya reviewed every pull request — this was her first time seeing Terraform in production, and we made it a learning exercise, not just a handoff.

**Sprint 2 — Application Containerisation**
The Node.js API rewrite was done in tandem. Two engineers worked on Dockerfiles and the Express app while the DevOps engineer finalized the ECS task definition and ALB target groups. The first successful deployment to the dev environment happened on day 9 of the sprint.

**Sprint 3 — Hardening + Cutover**
Load testing with k6. Chaos-lite: we manually drained ECS tasks during a simulated load test to confirm ALB health checks worked and new tasks spun up. RDS failover rehearsal. CloudWatch alarms tuned. Priya ran a complete deployment independently — first time in four years she hadn't been flying by memory.

**Sprint 4 — Handover + Monitoring**
Runbooks written. Dashboard links shared with Daniel. On-call rotation established with the team (four people, PagerDuty integration). Post-engagement training session for the two junior engineers.

---

## 8. Team Structure

| Role | Person | Responsibility |
|------|--------|----------------|
| **Project Manager** | Kavya Reddy (CloudBlitz) | Scope, sprint tracking, stakeholder updates to Daniel Rivera |
| **Cloud Architect** | Naman Gupta (CloudBlitz) | AWS target architecture, security review, cost model |
| **DevOps Engineer** | Rohan Sharma (CloudBlitz) | Terraform modules, ECS, CI setup, observability |
| **Backend Developer** | Priya Venkatesan (RiverMarket) | Node.js API, DB migrations, health endpoints |
| **QA Engineer** | Shivam Kapoor (CloudBlitz) | Load tests, regression on /health and /api/products, cutover smoke |

---

## 9. Meetings Structure

### Daily Standup — 9:30 AM EST (15 minutes)

Rohan's standup update on a typical Tuesday in Sprint 2:
> *"Yesterday: got ECS task definition working with Secrets Manager injection — confirmed DATABASE_URL is not visible in ECS console logs. Today: wiring the ALB health check to /health endpoint and pushing to ECR. Blocked: Priya needs to review the DB migration SQL before I can confirm the schema matches what the API expects."*

### Sprint Planning — Every other Monday (90 minutes)
Daniel attended every Sprint Planning to align on priorities. The team used Jira with story points. Acceptance criteria were written before any work started.

### Sprint Review — Every other Friday (45 minutes)
Live demo to Daniel and the new VP of Partnerships. By Sprint 3, they were watching k6 load test results in real time — the API handling 500 requests/second without any 5xx errors. Daniel's reaction: *"This is the first time I've felt good about our infrastructure in two years."*

### Retrospective — Every other Friday, after Review (25 minutes)
Anonymous input via Retrium. Key themes across the four sprints: IaC learning curve was steep but worth it; RDS parameter group tuning took longer than estimated; Priya felt more confident by Sprint 4 than at any point in her tenure.

---

## 10. Ticketing System (Simulated — Jira)

| Ticket | Title | Details | Priority | Owner | Status |
|--------|--------|---------|----------|-------|--------|
| **RM-101** | Terraform VPC + subnets | Public/private subnets across 2 AZs; IGW and route tables | P1 | Rohan | ✅ Done |
| **RM-102** | ECS Fargate cluster + task definition | Fargate launch type; CPU 512 / Mem 1024 for dev | P1 | Rohan | ✅ Done |
| **RM-103** | RDS PostgreSQL + Secrets Manager | `DATABASE_URL` injected into task via `secrets:` block | P1 | Rohan | ✅ Done |
| **RM-104** | ECR repository + deploy script | `scripts/deploy.sh` builds, tags, pushes, force-deploys | P1 | Rohan | ✅ Done |
| **RM-105** | ALB + target group + health check | Health check to /health; deregistration delay 30s | P1 | Rohan | ✅ Done |
| **RM-106** | Node.js API — /health + /api/products | Express + pg Pool; responds with JSON | P1 | Priya | ✅ Done |
| **RM-107** | DB migration — 001_init.sql | `products` table schema + seed data | P2 | Priya | ✅ Done |
| **RM-108** | CloudWatch alarms — ALB 5xx + ECS CPU | Threshold: 5xx > 10 in 5min; CPU > 80% | P2 | Rohan | ✅ Done |
| **RM-109** | S3 bucket + encryption policy | SSE-S3; versioning enabled; lifecycle 90-day archive | P2 | Rohan | ✅ Done |
| **RM-110** | DR drill — RDS snapshot restore | Quarterly; documented in runbook | P3 | Kavya | 📋 Scheduled |

---

## 11. Day-to-Day Activities — What a DevOps Engineer Does on This Project

*You are Rohan. It's Wednesday morning, Sprint 3.*

You start by checking the CloudWatch dashboard — the one you built last week. ALB request count, ECS CPU, RDS connections. Everything green.

Priya has pushed a new version of the API that adds a `category_filter` query parameter to `/api/products`. You pull the branch and review her Dockerfile changes. One thing catches your eye: she's copying `node_modules` in a way that will break the Docker cache. You leave a comment, suggest a fix, she updates it. The image builds in 2 minutes instead of 8.

You trigger `./scripts/deploy.sh rivermarket-dev api`. Watch the ECR push complete. Watch ECS show "0/2 running, 2/2 desired" as the old tasks drain. Then "2/2 running, 2/2 desired." You hit the ALB URL with curl. New endpoint works.

At standup you mention the Dockerfile cache issue — now the whole team knows the pattern. By Friday, Priya has taught it to the two junior engineers herself.

After lunch: a Jira ticket from Daniel — finance wants cost-allocation tags on every resource. You spend two hours adding `environment`, `project`, and `owner` tags across all the Terraform modules. You run `terraform plan` — 28 resource updates, zero destroys. You open a PR.

End of day: update RM-108 status to In Progress, post your async standup note, check ECS task count one more time.

---

## 12. Delivery Timeline

| Week | Activity | Key Deliverable |
|------|----------|----------------|
| **Weeks 1–2** | Assessment + IaC foundation | VPC, RDS, Secrets Manager, ECS baseline in dev |
| **Weeks 3–4** | API containerisation + ALB | First successful deployment; ALB serving traffic |
| **Weeks 5–6** | Hardening + cutover prep | Load test results, CloudWatch dashboards, runbooks |
| **Week 6 (final)** | Handover + training | Team can operate independently; documentation complete |

**Total engagement: 6 weeks.** RiverMarket ran their next major flash sale 8 weeks after the handover — no incidents.

---

## 13. Cost Estimation

| Item | Monthly Cost (Dev/Stage) | Notes |
|------|--------------------------|-------|
| **ECS Fargate** (2 tasks, 0.5 vCPU / 1GB) | ~$25–35 | Scales higher in prod; pay only for running task-seconds |
| **RDS PostgreSQL** (db.t3.micro, single-AZ) | ~$25 | Multi-AZ in prod adds ~$50 |
| **Application Load Balancer** | ~$20 | LCU pricing variable on actual traffic |
| **NAT Gateway** | ~$35 | Fixed hourly + data processing |
| **ECR** (image storage) | ~$2–5 | Per-GB storage + data transfer |
| **Secrets Manager** | ~$1 | $0.40/secret/month |
| **CloudWatch** (logs + alarms) | ~$10–15 | Log ingestion volume-dependent |
| **S3** | ~$5 | Minimal for marketing assets |
| **Total (dev footprint)** | **~$120–140/month** | |

| Item | Cost |
|------|------|
| **CloudBlitz professional services (6 weeks)** | **USD $55,000–72,000 / ₹46L–60L** |
| **Total project (incl. PM + QA)** | **USD $60,000–80,000** |

*Infrastructure costs are for a dev environment. A production deployment with Multi-AZ RDS, more Fargate tasks, and additional monitoring would be $300–500/month.*

---

## 14. Outcomes & Business Impact

Six months after the engagement, Daniel sent CloudBlitz a case study update:

- **Deployment time**: from a 3.5-hour Thursday night ceremony by one engineer → to a 12-minute automated workflow any engineer can trigger
- **Incident count**: zero major outages in the 6 months post-deployment, including two major flash sales
- **Security posture**: eleven hard-coded credentials removed from code; all secrets now in Secrets Manager with automatic rotation enabled
- **Team confidence**: two junior engineers can now run deployments independently
- **Cost visibility**: tagging and Cost Explorer dashboards gave finance the breakdown they'd been asking for

RiverMarket signed a follow-on engagement with CloudBlitz for Phase 2: automated CI/CD with CodePipeline and blue/green deployments.

---

## 15. How This Project Runs in a Real Company

In the months after handover, RiverMarket's deployment process looked like this:

A developer merges a PR to `main`. They open their terminal, run `./scripts/deploy.sh rivermarket-prod api`. The script builds the Docker image, pushes it to ECR with a git-SHA tag, and triggers an ECS rolling deployment. The ALB health check validates each new task before draining the old one. The whole process takes 10–15 minutes. CloudWatch shows the deployment completing with zero 5xx errors. Done.

If something goes wrong — a bad migration, an API regression — the rollback is `aws ecs update-service --force-new-deployment` pointing at the previous task definition revision. It takes 5 minutes. The postmortem happens within 48 hours. The runbook is updated.

For planned database changes, a 15-minute maintenance window is booked in the team calendar. Priya runs the migration SQL via RDS Query Editor (the DB is private — no direct access). The API handles the schema change gracefully because all migrations are backwards-compatible additive-only changes.

---

## 16. Key Learning for Students

This project is a blueprint for how most mid-market companies modernise their infrastructure. You are not building a toy. The decisions made here — ECS over EC2, Fargate over self-managed nodes, Secrets Manager over environment variables, Terraform over ClickOps — are the same decisions that Platform Engineering teams make in companies with 10x the scale.

When you complete this project, you will be able to explain **why** managed services reduce operational risk, not just **how** to use them. You will understand the cost trade-offs of Fargate vs EC2. You will know how to give a deployment runbook to someone who wasn't in the room when the architecture was designed.

That's what makes the difference between a junior engineer and a mid-level platform engineer. This project is the bridge.

---

© 2026 Greamio Technologies Private Limited. CloudBlitz curriculum material.
