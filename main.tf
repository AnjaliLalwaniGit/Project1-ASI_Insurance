provider "aws" {
  access_key = "XXXXXXXXXXXXXXXX" ## replace with your access key
  secret_key = "XXXXXXXXXXXXXXXXXXXXX" ## replace with your secret key
  token      = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX" ## replace with token 
  region     = "us-east-1"
}

resource "aws_security_group" "p1_sg" {
  name        = "p1_sg"
  description = "Project1 security group"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow HTTP access from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow HTTPS access from anywhere
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 81
    to_port     = 81
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

   # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }


}

# Define the key pair for SSH access
resource "aws_key_pair" "key_pair" {
  key_name   = "your-key-name"
  public_key = file("~/.ssh/your-public-key.pub")
}

resource "aws_instance" "project1_instance" {
  ami                    = "ami-06aa3f7caf3a30282" # Canonical, Ubuntu, 20.04 LTS, amd64 focal image build on 2023-10-25
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.p1_sg.id]

  tags = {
    Name = "project1"
  }

  }

  output "public_ip" {
    value = aws_instance.project1_instance.public_ip
  }
