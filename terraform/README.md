# Secure AWS DevSecOps

## Overview

Secure AWS DevSecOps is a security-focused AWS infrastructure project built with Terraform.

The project demonstrates how to provision AWS infrastructure using Infrastructure as Code while implementing core cloud security controls, centralized monitoring, least-privilege IAM, secure storage, and security alerting.

## Architecture

The project includes:

- AWS VPC
- Public Subnet
- Internet Gateway
- Route Table
- EC2 Web Server
- Security Groups
- IAM Role and Instance Profile
- Secure S3 Bucket
- AWS CloudTrail
- CloudWatch Logs
- CloudWatch Metric Filter
- CloudWatch Alarm
- Amazon SNS

## Security Controls

### IAM Least Privilege

The EC2 instance uses an IAM role with limited permissions required for S3 access.

The project avoids granting unnecessary administrative permissions to the workload.

### S3 Security

The S3 bucket is protected with:

- Server-side encryption
- Public access block
- Versioning
- Restricted IAM access

### EC2 Security

The EC2 instance uses:

- Encrypted root volume
- IMDSv2
- IAM instance profile
- Security Group controls

### CloudTrail

AWS API activity is monitored through CloudTrail to provide an audit trail for security investigations.

### CloudWatch Monitoring

CloudWatch monitors selected security-related API activity using metric filters and alarms.

Detected events can trigger CloudWatch alarms and SNS notifications.

### SNS Alerting

Amazon SNS provides a notification mechanism for critical security events detected by the monitoring system.

## Infrastructure as Code

The entire infrastructure is managed using Terraform.

Main benefits:

- Reproducible infrastructure
- Version-controlled configuration
- Consistent deployments
- Infrastructure validation
- Easier security review

## Project Structure

```text
secure-aws-devsecops/
├── terraform/
│ ├── main.tf
│ ├── ec2.tf
│ ├── cloudtrail.tf
│ ├── security-monitoring.tf
│ ├── iam-policy.json
│ ├── architecture.md
│ ├── terraform.tfstate
│ └── terraform.tfstate.backup
└── README.md
Security Monitoring Flow
AWS API Activity
       |
       v
   CloudTrail
       |
       v
 CloudWatch Logs
       |
       v
 Metric Filter
       |
       v
 CloudWatch Alarm
       |
       v
      SNS
       |
       v
 Security Notification
Validation
Terraform configuration was validated using:
terraform validate
terraform plan
The final Terraform plan confirmed that the deployed infrastructure matches the Terraform configuration.
Security Review
The project was reviewed for:
IAM least privilege
S3 protection
EC2 security
CloudTrail logging
CloudWatch monitoring
Security alerting
Terraform configuration consistency
Production Improvements
For a production environment, additional controls could include:
AWS Systems Manager Session Manager instead of SSH
AWS Secrets Manager for application secrets
AWS GuardDuty
AWS Security Hub
AWS Config
VPC Flow Logs
Centralized multi-account logging
Automated CI/CD security scanning
Terraform security scanning with tools such as Checkov or tfsec
Technologies
AWS
Terraform
Linux
IAM
EC2
VPC
S3
CloudTrail
CloudWatch
SNS
Infrastructure as Code
Cloud Security
DevSecOps
Project Goal
The goal of this project is to demonstrate practical implementation of AWS cloud security controls using Terraform and to build a foundation for secure, monitored, and repeatable cloud infrastructure.
Author
Ibrahim Bishar Yusuf
