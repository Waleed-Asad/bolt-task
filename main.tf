terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.28.0"
    }
  }
  backend "s3" {
    bucket = "terraform-bolt-infra-state"
    key = "state/terraform.tfstate"
    dynamodb_table = "terraform-bolt-infra-state"
    region = "us-east-2"
  }
}

module "account-1" {
  source  = "./account-1/"
  assume_role_name = var.account_1_assume_role
  region = var.region
  assets_bucket_id = module.account-2.assets_bucket_id
  assets_bucket_regional_domain_name = module.account-2.assets_bucket_regional_domain_name
  environment = var.environment
}

module "account-2" {
  source  = "./account-2/"
  assume_role_name = var.account_2_assume_role
  region = var.region
  environment = var.environment
  cloudfront_arn = module.account-1.cloudfront_arn
}