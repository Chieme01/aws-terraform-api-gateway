# Function name variable
variable "function_name" {
  description = "Name of the Lambda function"
  type        = string
  default     = "example_lambda_function"
}

variable "api_gw_name" {
  description = "Name of the API Gateway"
  type        = string
  default     = "weather-check-api-gw"
}