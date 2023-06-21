output "invoke_arn" {
  value = aws_lambda_function.lambdaFunction.invoke_arn
}
output "function_name" {
  value =aws_lambda_function.lambdaFunction.function_name
}
