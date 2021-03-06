
data archive_file lambdazip {
  type        = "zip"
  output_path = "${path.module}/lambda_function.zip"
  source_dir  = "${path.module}/lambda"
}

resource aws_lambda_function lambda {
  function_name = local.lambda_name
  role          = aws_iam_role.lambda.arn
  publish       = true
  runtime       = "nodejs12.x"
  handler       = "index.handler"
  tags          = local.tags

  filename         = data.archive_file.lambdazip.output_path
  source_code_hash = data.archive_file.lambdazip.output_base64sha256
}
