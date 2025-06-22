terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.0.0-beta3"
    }
  }
}

terraform {
  backend "s3" {
    bucket  = "my-logs-un"
    key     = "terrafrom.tfstate"
    region  = "ap-south-1"
    profile = "default"
  }
}

provider "aws" {
  # Configuration options
  region = "ap-south-1"
  profile = "default"
}