

provider "aws" {
    region = "eu-north-1"
  
}
 
 data "aws_availability_zones" "available" {
    state = "available"
   
 }



module "vpc" {
    source = "terraform-aws-modules/vpc/aws"
    version = "5.8.1"
  
    name = "my-vpc"
    cidr = "10.0.0.0/16"
    

    azs = data.aws_availability_zones.available.names
    private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
    public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

    tags = {
      Name = "test-vpc-module"
    }
}

