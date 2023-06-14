resource "aws_lambda_function" "lambda-function" {
  function_name = "${var.name}-lambda-function"
  description   = "${var.name} lambda function"
  handler       = var.handler
  runtime       = var.runtime
  filename      = var.filename
  role          = aws_iam_role.lambda_role.arn
  depends_on    = [aws_iam_role_policy_attachment.lambda_policy]
  vpc_config {
    security_group_ids = [data.aws_security_group.default-sg.id]
    subnet_ids         = var.subnet_ids
  }
}

data "aws_iam_policy_document" "AWSLambdaTrustPolicy" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "lambda_role" {
  name               = "lambda_role"
  assume_role_policy = data.aws_iam_policy_document.AWSLambdaTrustPolicy.json
}

resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}