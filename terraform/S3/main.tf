provider "aws" {
  region = var.region
}

module "s3" {
  source = "/S3"

  bucket = var.bucket
}