resource "aws_api_gateway_rest_api" "rest_api_gateway" {
  name        = var.name
}

resource "aws_api_gateway_resource" "rest_api_gateway_resource" {
  path_part   = var.path_part
  parent_id   = aws_api_gateway_rest_api.rest_api_gateway.root_resource_id
  rest_api_id = aws_api_gateway_rest_api.rest_api_gateway.id
}

resource "aws_api_gateway_method" "rest_api_gateway_method" {
  rest_api_id   = aws_api_gateway_rest_api.rest_api_gateway.id
  resource_id   = aws_api_gateway_resource.rest_api_gateway_resource.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "rest_api_gateway_integration" {
  rest_api_id = aws_api_gateway_rest_api.rest_api_gateway.id
  resource_id = aws_api_gateway_resource.rest_api_gateway_resource.id
  http_method = aws_api_gateway_method.rest_api_gateway_method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.invoke_arn
}

resource "aws_lambda_permission" "rest_api_gateway_invoke_permission" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = "${var.function_name}"
  principal     = "apigateway.amazonaws.com"
  source_arn = "${aws_api_gateway_rest_api.rest_api_gateway.execution_arn}/*/*"
}

resource "aws_api_gateway_deployment" "rest_api_gateway_deployment" {
  depends_on = [
    aws_api_gateway_integration.rest_api_gateway_integration
  ]
  rest_api_id = "${aws_api_gateway_rest_api.rest_api_gateway.id}"
  stage_name = var.stage_name
 variables = {
   deployed_at = "${timestamp()}"
 }
}