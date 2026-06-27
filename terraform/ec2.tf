resource "aws_instance" "jenkins" {
  count         = 1
  ami           = "ami-0532913178263be11"
  instance_type = "t3.small"
  subnet_id     = aws_subnet.public1.id
  vpc_security_group_ids = [
    aws_security_group.dev_sg.id
  ]
  key_name = "singapore"

  tags = {
    Name = "Jenkins"
  }
}

resource "aws_instance" "docker" {
  count         = 1
  ami           = "ami-0532913178263be11"
  instance_type = "t3.small"
  subnet_id     = aws_subnet.public1.id
  vpc_security_group_ids = [
    aws_security_group.dev_sg.id
  ]
  key_name = "singapore"

  tags = {
    Name = "Docker"
  }
}

resource "aws_instance" "eks" {
  count         = 1
  ami           = "ami-0532913178263be11"
  instance_type = "t3.small"
  subnet_id     = aws_subnet.public1.id
  vpc_security_group_ids = [
    aws_security_group.dev_sg.id
  ]
  key_name = "singapore"
  tags = {
    Name = "EKS"
  }
}
