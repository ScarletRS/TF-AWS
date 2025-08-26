




terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.region  
}

# Create an instance
resource "aws_instance" "myserver" {
  ami           = "ami-020cba7c55df1f615"
  instance_type = "t2.micro"

  tags = {
    Name = "sampleserver"
  }
}
