resource "aws_lambda_function" "lambda_function" {
  function_name = var.function_name
  role          = aws_iam_role.iam_for_lambda.arn

  image_uri     = "${aws_ecr_repository.lambda_ecr.repository_url}:latest"
  package_type  = "Image"
}
