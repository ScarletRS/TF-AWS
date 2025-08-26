

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket = "Write Here Bucket id from the the bucket you created"
    key = "backend.tfstate"
    region = "us-east-1"
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us -east-1" 
}

# Create an instance
resource "aws_instance" "myserver" {
  ami           = "ami-020cba7c55df1f615"
  instance_type = "t2.micro"

  tags = {
    Name = "sampleserver"
  }
}
