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