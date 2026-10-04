

resource "aws_kms_key" "cloudtrail" {
  description             = "KMS key for Secure AWS DevSecOps CloudTrail"
  enable_key_rotation     = true
  deletion_window_in_days = 30

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "EnableAccountAdministration"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        }
        Action   = "kms:*"
        Resource = "*"
      },
      {
        Sid    = "AllowCloudTrailEncryption"
        Effect = "Allow"
        Principal = {
          Service = "cloudtrail.amazonaws.com"
        }
        Action = [
          "kms:GenerateDataKey*",
          "kms:DescribeKey"
        ]
        Resource = "*"
        Condition = {
          StringLike = {
            "kms:EncryptionContext:aws:cloudtrail:arn" = "arn:aws:cloudtrail:*:${data.aws_caller_identity.current.account_id}:trail/*"
          }
        }
      }
    ]
  })

  tags = {
    Name    = "secure-devsecops-cloudtrail-kms"
    Project = "Secure AWS DevSecOps"
  }
}

resource "aws_kms_alias" "cloudtrail" {
  name          = "alias/secure-devsecops-cloudtrail"
  target_key_id = aws_kms_key.cloudtrail.key_id
}
