output "functions" {
  value = local.functions
}

output "methods" {
  value = local.methods
}

output "aws_api_gateway_resource" {
  value = aws_api_gateway_resource.resources
}

output "aws_api_gateway_method" {
  value = aws_api_gateway_method.methods
}

output "resources_map" {
  value = local.api_resources_map
}

output "api_resources" {
  value = local.api_resources
}