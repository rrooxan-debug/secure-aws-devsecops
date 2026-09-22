# Secure AWS DevSecOps Infrastructure

A production-inspired AWS security infrastructure project built with
Terraform, AWS CloudTrail, CloudWatch, IAM, VPC, EC2, S3, and SNS.

## 🚀 Project Overview

This project demonstrates how to build and secure AWS infrastructure
using Infrastructure as Code (IaC).

The infrastructure includes:

- Secure S3 storage
- IAM least-privilege access
- Custom VPC networking
- Public subnet and Internet Gateway
- EC2 web server
- EC2 IAM Instance Profile
- CloudTrail auditing
- CloudWatch log monitoring
- Security metric filtering
- CloudWatch security alarms
- SNS security notifications
- Email alerting

## 🏗️ Architecture

```text
                    GitHub
                       |
                       v
                  Terraform
                       |
                       v
              +----------------+
              | AWS |
              +----------------+
                       |
        +--------------+--------------+
        | | |
        v v v
       VPC S3 IAM
        | | |
     Subnet Encryption Least Privilege
        |
       EC2
        |
        +----------------------+
                               |
                               v
                          CloudTrail
                               |
                    +----------+----------+
                    | |
                    v v
              CloudWatch Logs S3 Audit Logs
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
             Email Security Alert
