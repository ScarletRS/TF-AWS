
terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "5.54.1"
    }
  }
}

provider "aws" {
    region = "eu-north-1"
  
}

#create a vpc

resource "aws_vpc" "my_vpc" {
   cidr_block = "10.0.0.0/16"
   tags = {
        Name = "my_vpc"
   } 
  
}

#private subnet
resource "aws_subnet" "private_subnet" {
    cidr_block = "10.0.1.0/24"
    vpc_id = aws_vpc.my_vpc.id
    tags = {
      Name = "private_subnet"
    }
  
}

#public subnet
resource "aws_subnet" "public_subnet" {
    cidr_block = "10.0.2.0/24"
    vpc_id = aws_vpc.my_vpc.id
    tags = {
      Name = "public_subnet"
    }
  
}

#Internet Gateway
resource "aws_internet_gateway" "my-igw" {
    vpc_id = aws_vpc.my_vpc.id
    tags = {
      Name = "my-igw"
    }
  
}

#Route Table
resource "aws_route_table" "my_rt" {
  vpc_id = aws_vpc.my_vpc.id


  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-igw.id
  }

  tags = {
    Name = "my_rt"
  }
}


# Route Table Association for Public Subnet
resource "aws_route_table_association" "public-sub" {
    route_table_id = aws_route_table.my_rt.id
    subnet_id = aws_subnet.public_subnet.id
  
}

 # Create an instance
resource "aws_instance" "myserver" {
  ami           = "ami-020cba7c55df1f615"
  instance_type = "t3.micro"

  subnet_id = aws_subnet.public_subnet.id 


  tags = {
    Name = "sampleserver"
  }
}
