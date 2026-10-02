# Secure AWS DevSecOps Architecture

## Architecture Overview

The Secure AWS DevSecOps project uses AWS infrastructure managed through Terraform.

The architecture combines secure networking, IAM least privilege, protected storage, centralized audit logging, monitoring, and automated security alerting.

## Infrastructure Architecture

```text
                    Internet
                       |
                       v
                Internet Gateway
                       |
                       v
                 Public Subnet
                       |
              +--------+--------+
              | |
              v v
          EC2 Web Server Security Group
              |
              v
        IAM Instance Role
              |
              v
         Secure S3 Bucket


Security Monitoring:

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
Network Security
The infrastructure uses an isolated VPC with a dedicated public subnet.
Network components include:
VPC
Public subnet
Internet Gateway
Route table
Security Groups
Security Groups control inbound and outbound traffic to the EC2 workload.
Compute Security
The EC2 instance is configured with security-focused settings including:
Encrypted EBS root volume
IMDSv2 required
IAM instance profile
Restricted security group rules
Identity and Access Management
The EC2 workload uses an IAM role rather than storing AWS credentials directly on the instance.
The role follows the principle of least privilege and provides only the permissions required for the workload.
S3 Security
The S3 bucket is configured with:
Server-side encryption
Public access block
Versioning
Restricted IAM access
These controls reduce the risk of accidental public exposure and help protect stored objects.
Logging and Monitoring
AWS CloudTrail records API activity.
CloudTrail logs are integrated with CloudWatch Logs.
A CloudWatch metric filter detects selected security-related API activity.
The resulting metric is monitored by a CloudWatch alarm.
Alerting
When the configured security metric reaches the alarm threshold, CloudWatch can trigger an SNS notification.
This creates the following security monitoring flow:
API Event
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
Security Alert
Infrastructure as Code
Terraform is used to provision and manage the AWS infrastructure.
Benefits include:
Repeatable deployments
Version-controlled infrastructure
Consistent configuration
Easier security auditing
Reduced manual configuration
Security Design Principles
The project follows these core principles:
Least privilege
Defense in depth
Encryption
Continuous monitoring
Auditability
Infrastructure as Code
Controlled network access
Production Security Enhancements
For a production environment, the architecture could be extended with:
AWS GuardDuty
AWS Security Hub
AWS Config
VPC Flow Logs
AWS Systems Manager Session Manager
AWS Secrets Manager
Centralized multi-account logging
CI/CD security scanning
Conclusion
This architecture demonstrates a practical foundation for securing AWS workloads using Terraform and native AWS security services.
The design combines preventive controls, detective controls, monitoring, and alerting to provide a stronger cloud security posture.

