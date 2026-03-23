resource "aws_api_gateway_rest_api" "api_gw" {
  name = var.api_gw_name

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_deployment" "api_gw_deployment" {
  rest_api_id = aws_api_gateway_rest_api.api_gw.id

  triggers = {
    redeployment = sha1(jsonencode([
        aws_api_gateway_resource.resources,
        aws_api_gateway_method.methods,
        aws_api_gateway_integration.lambda_integrations
        ]))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "dev_stage" {
  deployment_id = aws_api_gateway_deployment.api_gw_deployment.id
  rest_api_id   = aws_api_gateway_rest_api.api_gw.id
  stage_name    = "dev"
}

# In AWS GUI, API resources will be identified by path and Resource ID, not by the for-loop's each.key
resource "aws_api_gateway_resource" "resources" {
  for_each      = local.api_resources
  path_part     = each.value.path
  parent_id     = aws_api_gateway_rest_api.api_gw.root_resource_id
  rest_api_id   = aws_api_gateway_rest_api.api_gw.id
}

resource "aws_api_gateway_method" "methods" {
  for_each      = local.methods
  rest_api_id   = aws_api_gateway_rest_api.api_gw.id
  resource_id   = aws_api_gateway_resource.resources[each.value.resource].id
  http_method   = each.value.method
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda_integrations" {
  for_each                  = local.functions
  rest_api_id               = aws_api_gateway_rest_api.api_gw.id
  resource_id               = aws_api_gateway_resource.resources[each.value.resource].id
  http_method               = aws_api_gateway_method.methods[each.value.end_point_name].http_method
  integration_http_method   = "POST"
  type                      = "AWS_PROXY"
  uri                       = aws_lambda_function.backend_lambdas[each.key].invoke_arn
}