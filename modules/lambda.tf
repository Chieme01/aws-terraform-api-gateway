resource "aws_lambda_function" "example" {
  filename      = data.archive_file.example.output_path
  function_name = var.function_name
  role          = aws_iam_role.lambda_execution_role.arn
  handler       = "main.lambda_handler"
  source_code_hash   = data.archive_file.source_code.output_base64sha256

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

# Package the Lambda function code
data "archive_file" "source_code" {
  type        = "zip"
  source_file = "${path.module}/python/main.py"
  output_path = "${path.module}/python/function.zip"
}

# CloudWatch Log Group with retention
resource "aws_cloudwatch_log_group" "log_group" {
  name              = "/aws/lambda/${var.function_name}"
  retention_in_days = 14

  tags = {
    Environment = "production"
    Function    = var.function_name
  }
}