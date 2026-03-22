module "api-gateway" {
    source                  = "./modules"
    #bucket_name             = var.bucket_name

    # Pass BOTH the default and the aliased provider
    providers = {
      aws       = aws       # Passes us-west-1
      aws.east  = aws.east  # Passes us-east-1
    }
}