########################################
# EC2 ROLE – Audit Event Emitter
########################################

resource "aws_iam_role" "ec2_audit_role" {
  name = "ec2-audit-emitter-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_policy" "ec2_eventbridge_policy" {
  name = "ec2-put-audit-events"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Action = [
        "events:PutEvents"
      ],
      Resource = "*"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ec2_attach" {
  role       = aws_iam_role.ec2_audit_role.name
  policy_arn = aws_iam_policy.ec2_eventbridge_policy.arn
}

########################################
# EC2 INSTANCE PROFILE (REQUIRED)
########################################

resource "aws_iam_instance_profile" "profile" {
  name = "ec2-audit-emitter-profile"
  role = aws_iam_role.ec2_audit_role.name
}

########################################
# LAMBDA ROLE – Controlled S3 Writer
########################################

resource "aws_iam_role" "lambda_role" {
  name = "lambda-audit-writer-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "lambda.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

########################################
# Lambda → CloudWatch Logs (MANDATORY)
########################################

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

########################################
# Lambda → S3 Write-Only Policy (CORRECT)
########################################

resource "aws_iam_policy" "lambda_s3_policy" {
  name = "lambda-s3-write-only"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:PutObject"
        ],
        Resource = "${aws_s3_bucket.evidence.arn}/*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_attach" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_s3_policy.arn
}
