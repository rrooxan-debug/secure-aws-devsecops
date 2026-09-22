# =========================================================
# SECURE AWS DEVSECOPS - SECURITY MONITORING
# =========================================================

# ---------------------------------------------------------
# 1. CloudWatch Metric Filter
# Detect unauthorized AWS API activity from CloudTrail
# ---------------------------------------------------------

resource "aws_cloudwatch_log_metric_filter" "unauthorized_api_calls" {
  name           = "secure-devsecops-unauthorized-api-calls"
  log_group_name = aws_cloudwatch_log_group.cloudtrail_logs.name

  pattern = "{ ($.errorCode = AccessDenied) || ($.errorCode = UnauthorizedOperation) }"

  metric_transformation {
    name      = "UnauthorizedAPICalls"
    namespace = "SecureDevSecOps/Security"
    value     = "1"
  }
}

# ---------------------------------------------------------
# 2. SNS Topic
# Security incident notification channel
# ---------------------------------------------------------

resource "aws_sns_topic" "security_alerts" {
  name = "secure-devsecops-security-alerts"

  tags = {
    Name    = "secure-devsecops-security-alerts"
    Project = "Secure AWS DevSecOps"
  }
}

# ---------------------------------------------------------
# 3. CloudWatch Alarm
# Trigger when unauthorized API activity is detected
# ---------------------------------------------------------

resource "aws_cloudwatch_metric_alarm" "unauthorized_api_alarm" {
  alarm_name          = "secure-devsecops-unauthorized-api-alarm"
  alarm_description   = "Alerts when unauthorized AWS API activity is detected."
  namespace           = "SecureDevSecOps/Security"
  metric_name         = "UnauthorizedAPICalls"
  statistic           = "Sum"
  period              = 300
  evaluation_periods  = 1
  threshold           = 1
  comparison_operator = "GreaterThanOrEqualToThreshold"

  treat_missing_data = "notBreaching"

  alarm_actions = [
    aws_sns_topic.security_alerts.arn
  ]

  tags = {
    Name    = "secure-devsecops-unauthorized-api-alarm"
    Project = "Secure AWS DevSecOps"
  }
}
# ---------------------------------------------------------
# 4. SNS Email Subscription
# ---------------------------------------------------------

resource "aws_sns_topic_subscription" "security_email" {
  topic_arn = aws_sns_topic.security_alerts.arn
  protocol  = "email"
  endpoint  = "rrooxan@gmail.com"
}
