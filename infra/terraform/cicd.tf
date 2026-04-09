resource "aws_codebuild_project" "api" {
  count = var.codebuild_github_repo != "" ? 1 : 0

  name          = "${var.project_name}-${var.environment}-api-build"
  description   = "Build and push RiverMarket API image to ECR"
  build_timeout = 30
  service_role  = aws_iam_role.codebuild[0].arn

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:7.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = true

    environment_variable {
      name  = "AWS_DEFAULT_REGION"
      value = var.aws_region
    }
    environment_variable {
      name  = "ECR_REPOSITORY_URI"
      value = aws_ecr_repository.api.repository_url
    }
    environment_variable {
      name  = "ECR_REGISTRY"
      value = split("/", aws_ecr_repository.api.repository_url)[0]
    }
  }

  source {
    type            = "GITHUB"
    location        = "https://github.com/${var.codebuild_github_repo}.git"
    git_clone_depth = 1
    buildspec       = "cicd/buildspec.yml"
  }

  logs_config {
    cloudwatch_logs {
      group_name  = aws_cloudwatch_log_group.codebuild[0].name
      stream_name = "build"
    }
  }

  tags = {
    Name = "${var.project_name}-codebuild"
  }
}

resource "aws_cloudwatch_log_group" "codebuild" {
  count             = var.codebuild_github_repo != "" ? 1 : 0
  name              = "/codebuild/${var.project_name}-${var.environment}/api"
  retention_in_days = 7
}
