



module "ec2-instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "6.0.2"


  name = "single-instance"

  ami          = "ami-06c68f701d8090592"

  instance_type = "t3.micro"
  vpc_security_group_ids = [module.vpc_security_group_ids]
  subnet_id     = module.vpc.public_subnets[0]

  tags = {
    Name = "module-project"
    Environment = "dev"
  }
}