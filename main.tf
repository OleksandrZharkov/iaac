terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.22.0"
    }
  }
  required_version = "~> 0.14"
}

provider "aws" {
  region = var.region
}
 
resource "aws_instance" "EC2" {
  ami           = "ami-0767046d1677be5a0"
  instance_type = "t2.micro"
}


