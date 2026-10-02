terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "secure_demo" {
  bucket_prefix = "ibrahim-secure-devsecops-"

  tags = {
    Project     = "Secure AWS DevSecOps"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_public_access_block" "secure_demo" {
  bucket = aws_s3_bucket.secure_demo.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "secure_demo" {
  bucket = aws_s3_bucket.secure_demo.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_versioning" "secure_demo" {
  bucket = aws_s3_bucket.secure_demo.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_security_group" "secure_ec2_sg" {
  name        = "secure-ec2-sg"
  description = "Security group for secure EC2 instance"
  vpc_id      = aws_vpc.secure_vpc.id

  ingress {
    description = "SSH from trusted network"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["196.188.252.131/32"]
  }

  egress {
    description = "Allow outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "secure-ec2-sg"
    Project = "Secure AWS DevSecOps"
  }
}
