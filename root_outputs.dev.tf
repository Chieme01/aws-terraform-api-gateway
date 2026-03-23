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

output "resources_map" {
  value = module.api-gateway.resources_map
}

output "api_resources" {
  value = module.api-gateway.api_resources
}