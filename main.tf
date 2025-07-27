provider "aws" {
  region = "us-east-1"
}

# Load your public key for the key pair
resource "aws_key_pair" "deployer" {
  key_name   = "inventoware_key"
  public_key = file("inventoware_key.pub") # Make sure this file exists
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
  ami           = "ami-0c02fb55956c7d316" # Amazon Linux 2
  instance_type = "t2.micro"
  key_name      = aws_key_pair.deployer.key_name
  security_groups = [aws_security_group.allow_ssh.name]

  tags = {
    Name = "inventoware-ec2"
  }
}

