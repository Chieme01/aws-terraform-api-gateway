terraform {
  backend "s3" {
    bucket                = "nyon-terraform-state-bucket"
    key                   = "aws-terraform.tfstate"
    workspace_key_prefix  = "workspaces"
    region                = "us-west-1"
    #profile              = var.aws_profile
  }
}