module "vpc" {
  source              = "../aws-module-creation"
  vpc_cidr            = "10.0.0.0/16"
  vpc_name            = "main-vpc"
  public_subnet_cidr  = "10.0.1.0/24"
  private_subnet_cidr = "10.0.2.0/24"
  availability_zone   = "ap-south-1a"
}