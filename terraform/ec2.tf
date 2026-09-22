resource "aws_iam_instance_profile" "secure_web_profile" {
  name = "SecureDevSecOpsS3InstanceProfile"
  role = "SecureDevSecOpsS3Role"

  tags = {
    Project = "Secure AWS DevSecOps"
  }
}

resource "aws_instance" "secure_web" {
  ami                         = "ami-0c02fb55956c7d316"
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.secure_public_subnet.id
  vpc_security_group_ids      = [aws_security_group.secure_web_sg.id]
  associate_public_ip_address = true

  iam_instance_profile = aws_iam_instance_profile.secure_web_profile.name

  root_block_device {
    encrypted = true
  }

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
  }

  tags = {
    Name    = "secure-devsecops-web"
    Project = "Secure AWS DevSecOps"
  }
}
