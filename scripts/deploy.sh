#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

REGION="${AWS_REGION:-us-east-1}"
ACCOUNT_ID="$(aws sts get-caller-identity --query Account --output text)"
ECR_URI="${ACCOUNT_ID}.dkr.ecr.${REGION}.amazonaws.com/rivermarket/api"

echo "Logging in to ECR..."
aws ecr get-login-password --region "$REGION" | docker login --username AWS --password-stdin "${ACCOUNT_ID}.dkr.ecr.${REGION}.amazonaws.com"

echo "Building image..."
docker build -f docker/Dockerfile -t "${ECR_URI}:latest" .

echo "Pushing..."
docker push "${ECR_URI}:latest"

CLUSTER="${1:-rivermarket-dev}"
SERVICE="${2:-api}"

echo "Forcing new ECS deployment on cluster=${CLUSTER} service=${SERVICE}..."
aws ecs update-service --cluster "$CLUSTER" --service "$SERVICE" --force-new-deployment --region "$REGION" >/dev/null

echo "Done. Watch: aws ecs describe-services --cluster $CLUSTER --services $SERVICE --region $REGION"
