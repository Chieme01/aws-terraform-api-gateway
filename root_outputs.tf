output "dev_stage_invoke_url" {
  value =  module.api-gateway.dev_stage_invoke_url
}

output "functions" {
  value = module.api-gateway.functions
}

output "methods" {
  value = module.api-gateway.methods
}

output "aws_api_gateway_resource" {
  value = module.api-gateway.aws_api_gateway_resource
}

output "aws_api_gateway_method" {
  value = module.api-gateway.aws_api_gateway_method
}