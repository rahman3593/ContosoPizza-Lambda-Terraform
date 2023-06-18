resource "aws_api_gateway_rest_api" "api" {
  name        = "${var.name}-api-gateway"
  description = "${var.name} api gateway"
}

resource "aws_api_gateway_resource" "lambda" {
  path_part   = "pizza"
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  rest_api_id = aws_api_gateway_rest_api.api.id
}

# How the gateway will be interacted from clientt
resource "aws_api_gateway_method" "lambda" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.lambda.id
  http_method   = "GET"
  authorization = "NONE"
}

# Integration between lambda and terraform
resource "aws_api_gateway_integration" "redirect" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.lambda.id
  http_method = aws_api_gateway_method.lambda.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.invoke_arn
}

resource "aws_lambda_permission" "apigw" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = "${var.function_name}"
  principal     = "apigateway.amazonaws.com"
  source_arn = "${aws_api_gateway_rest_api.api.execution_arn}/*/*"
}

resource "aws_api_gateway_deployment" "api_deployment" {
  depends_on = [
    aws_api_gateway_integration.redirect
  ]
  rest_api_id = "${aws_api_gateway_rest_api.api.id}"
  stage_name = "dev"
 variables = {
   deployed_at = "${timestamp()}"
 }
}