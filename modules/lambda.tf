resource "aws_lambda_function" "backend_lambdas" {
  for_each            = local.functions
  filename            = data.archive_file.source_codes[each.key].output_path
  function_name       = each.key #each.value.function_name
  role                = aws_iam_role.lambda_execution_role.arn
  handler             = "${each.key}.lambda_handler"
  source_code_hash    = data.archive_file.source_codes[each.key].output_base64sha256

  runtime = "python3.11"

  environment {
    variables = {
      ENVIRONMENT = "production"
      LOG_LEVEL   = "info"
    }
  }

  tags = {
    Environment = "production"
    Application = "example"
  }

  # Advanced logging configuration
  logging_config {
    log_format            = "JSON"
    application_log_level = "INFO"
    system_log_level      = "WARN"
  }

  # Ensure IAM role and log group are ready
  depends_on = [
    aws_iam_role_policy_attachment.lambda_logs,
    aws_cloudwatch_log_group.log_group
  ]
}

# Package the Lambda functions' code
data "archive_file" "source_codes" {
  for_each    = local.functions 
  type        = "zip"
  source_file = "${path.module}/python/${each.key}.py"
  output_path = "${path.module}/python/${each.key}.zip"
}

# CloudWatch Log Group with retention
resource "aws_cloudwatch_log_group" "log_group" {
  for_each          = local.functions #aws_lambda_function.backend_lambdas
  name              = "/aws/lambda/${each.key}"
  retention_in_days = 14

  tags = {
    Environment = "production"
    Function    = var.function_name
  }
}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
data "aws_partition" "current" {}

# Lambda
resource "aws_lambda_permission" "apigw_lambda" {
  for_each      = local.functions
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = each.key #each.value.function_name
  principal     = "apigateway.amazonaws.com"

  # More: http://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-control-access-using-iam-policies-to-invoke-api.html
  # source_arn = "arn:${data.aws_partition.current.partition}:execute-api:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:${aws_api_gateway_rest_api.api_gw.id}/*/${each.value.method}/${each.value.path}"
  source_arn = "${aws_api_gateway_rest_api.api_gw.execution_arn}/*/${each.value.method}/${each.value.path}"
}