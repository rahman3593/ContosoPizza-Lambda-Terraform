resource "aws_lambda_function" "lambdaFunction" {
  function_name = var.function_name
  handler       = var.handler
  runtime       = var.runtime
  filename      = var.filename
  role          = aws_iam_role.lambdaRole.arn
  depends_on    = [aws_iam_role_policy_attachment.lambdaPolicy]
  vpc_config {
    security_group_ids = [var.default_sg_id]
    subnet_ids         = var.subnet_ids
  }
  environment {
    variables = var.envVariables
  }
}

data "aws_iam_policy_document" "lambdaTrustPolicy" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "lambdaRole" {
  name               = var.role_name
  assume_role_policy = data.aws_iam_policy_document.lambdaTrustPolicy.json
}

resource "aws_iam_role_policy_attachment" "lambdaPolicy" {
  role       = aws_iam_role.lambdaRole.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}