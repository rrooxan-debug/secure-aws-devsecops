# Secure AWS DevSecOps Architecture

```mermaid
flowchart TD

    G[GitHub] --> T[Terraform]

    T --> VPC[AWS VPC]

    VPC --> SUB[Public Subnet]
    SUB --> EC2[EC2 Web Server]
    EC2 --> SG[Security Group]
    EC2 --> IAM[EC2 IAM Instance Profile]

    T --> S3[S3 Secure Bucket]
    S3 --> ENC[Encryption]
    S3 --> VER[Versioning]
    S3 --> PAB[Public Access Block]

    T --> CT[CloudTrail]

    CT --> S3
    CT --> CWL[CloudWatch Logs]

    CWL --> MF[Metric Filter]
    MF --> ALARM[CloudWatch Alarm]

    ALARM --> SNS[SNS Security Alerts]
    SNS --> EMAIL[Security Email]

    IAM --> POLICY[IAM Least Privilege Policy]
