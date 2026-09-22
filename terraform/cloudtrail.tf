# ---------------------------------------------------------
# Current AWS Account
# ---------------------------------------------------------

data "aws_caller_identity" "current" {}

# ---------------------------------------------------------
# CloudWatch Log Group
# ---------------------------------------------------------

resource "aws_cloudwatch_log_group" "cloudtrail_logs" {
  name              = "/aws/cloudtrail/secure-devsecops"
  retention_in_days = 30

  tags = {
    Name    = "secure-devsecops-cloudtrail-logs"
    Project = "Secure AWS DevSecOps"
  }
}

# ---------------------------------------------------------
# IAM Role: CloudTrail -> CloudWatch Logs
# ---------------------------------------------------------

resource "aws_iam_role" "cloudtrail_cloudwatch_role" {
  name = "SecureDevSecOpsCloudTrailCloudWatchRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "cloudtrail.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Project = "Secure AWS DevSecOps"
  }
}

# ---------------------------------------------------------
# IAM Policy: CloudTrail -> CloudWatch Logs
# ---------------------------------------------------------

resource "aws_iam_role_policy" "cloudtrail_cloudwatch_policy" {
  name = "SecureDevSecOpsCloudTrailCloudWatchPolicy"
  role = aws_iam_role.cloudtrail_cloudwatch_role.id

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Action = [
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]

        Resource = "${aws_cloudwatch_log_group.cloudtrail_logs.arn}:*"
      }
    ]
  })
}

# ---------------------------------------------------------
# S3 Bucket Policy for CloudTrail
# ---------------------------------------------------------

resource "aws_s3_bucket_policy" "cloudtrail_bucket_policy" {
  bucket = aws_s3_bucket.secure_demo.id

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Sid    = "AWSCloudTrailAclCheck"
        Effect = "Allow"

        Principal = {
          Service = "cloudtrail.amazonaws.com"
        }

        Action   = "s3:GetBucketAcl"
        Resource = aws_s3_bucket.secure_demo.arn

        Condition = {
          StringEquals = {
            "aws:SourceArn" = "arn:aws:cloudtrail:us-east-1:${data.aws_caller_identity.current.account_id}:trail/secure-devsecops-trail"
          }
        }
      },
      {
        Sid    = "AWSCloudTrailWrite"
        Effect = "Allow"

        Principal = {
          Service = "cloudtrail.amazonaws.com"
        }

        Action = "s3:PutObject"

        Resource = "${aws_s3_bucket.secure_demo.arn}/AWSLogs/${data.aws_caller_identity.current.account_id}/*"

        Condition = {
          StringEquals = {
            "s3:x-amz-acl"  = "bucket-owner-full-control"
            "aws:SourceArn" = "arn:aws:cloudtrail:us-east-1:${data.aws_caller_identity.current.account_id}:trail/secure-devsecops-trail"
          }
        }
      }
    ]
  })
}

# ---------------------------------------------------------
# CloudTrail Trail
# ---------------------------------------------------------

resource "aws_cloudtrail" "secure_trail" {
  name                          = "secure-devsecops-trail"
  s3_bucket_name                = aws_s3_bucket.secure_demo.id
  include_global_service_events = true
  is_multi_region_trail         = true
  enable_log_file_validation    = true

  cloud_watch_logs_group_arn = "${aws_cloudwatch_log_group.cloudtrail_logs.arn}:*"
  cloud_watch_logs_role_arn  = aws_iam_role.cloudtrail_cloudwatch_role.arn

  depends_on = [
    aws_iam_role_policy.cloudtrail_cloudwatch_policy,
    aws_s3_bucket_policy.cloudtrail_bucket_policy
  ]

  tags = {
    Name    = "secure-devsecops-trail"
    Project = "Secure AWS DevSecOps"
  }
}
