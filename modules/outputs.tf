output "dev_stage_invoke_url" {
  value = aws_api_gateway_stage.dev_stage.invoke_url
}

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