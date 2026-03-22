terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region  = "us-west-1"
  #profile = var.aws_profile
}

# Aliased AWS provider for a different region (e.g., us-east-1)
provider "aws" {
  alias  = "east"
  region = "us-east-1"
}
