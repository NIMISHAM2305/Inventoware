provider "aws" {
  region = "ap-south-1"
}

# Security group to allow SSH
resource "aws_security_group" "allow_ssh" {
  name        = "inventoware_ssh_sg"
  description = "Allow SSH access"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 instance
resource "aws_instance" "app_server" {
  ami           = "ami-0d0ad8bb301edb745" # Amazon Linux 2
  instance_type = "t3.micro"
  key_name      = "inventoware_key"
  security_groups = [aws_security_group.allow_ssh.name]

  tags = {
    Name = "inventoware-ec2"
  }
}

