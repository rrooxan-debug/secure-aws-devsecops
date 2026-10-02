resource "aws_security_group" "secure_web_sg" {
  name        = "secure-web-sg"
  description = "Security group for Secure AWS DevSecOps web server"
  vpc_id      = aws_vpc.secure_vpc.id

  # HTTP
  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # SSH
  ingress {
    description = "Allow SSH for administration"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["196.188.252.131/32"]
  }

  # Outbound traffic
  egress {
    description = "Allow outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "secure-web-sg"
    Project = "Secure AWS DevSecOps"
  }
}
