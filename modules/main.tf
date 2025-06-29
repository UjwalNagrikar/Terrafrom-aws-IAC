module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.21.0"

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs = ["ap-south-1a", "ap-south-1b", "ap-south-1c"] 
  private_subnets = ["10.0.1.0/24"]
  public_subnets  = ["10.0.2.0/24"]

  tags = {
    Name = "my-vpc-module"
  }
}

resource "aws_instance" "my-ec2" {
  ami            = "ami-0b09627181c8d5778"
  instance_type  = "t2.micro"
  subnet_id      = module.vpc.public_subnets[0]
  tags = {
    Name = "module-vpc"
  }
}