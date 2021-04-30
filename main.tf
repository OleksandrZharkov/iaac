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

resource "random_uuid" "randomid" {}

resource "aws_iam_user" "circleci" {
  name = var.user
  path = "/system/"
}

resource "aws_iam_access_key" "circleci" {
  user = aws_iam_user.circleci.name
}


resource "local_file" "circle_credentials" {
  filename = "tmp/circleci_credentials"
  content  = "${aws_iam_access_key.circleci.id}\n${aws_iam_access_key.circleci.secret}"
}

resource "aws_iam_user_policy" "circleci" {
  name   = "AllowCircleCI"
  user   = aws_iam_user.circleci.name
}

resource "aws_instance" "EC2" {
  ami           = "ami-0767046d1677be5a0"
  instance_type = "t2.micro"
}


