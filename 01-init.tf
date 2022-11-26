terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 4.38.0"
    }

    mongodbatlas = {
      version = "~> 1.6.0"
      source  = "mongodb/mongodbatlas"
    }
  }

  cloud {
    organization = "dakual"

    workspaces {
      name = "mongodb-atlas-demo"
    }
  }

  required_version = ">= 1.2.5"
}

provider "aws" {
  region  = var.aws_region
}

provider "mongodbatlas" {
  public_key  = var.atlas_pub_key
  private_key = var.atlas_priv_key
}

locals {
  name                = "test"
  environment         = "dev"
  cidr                = "10.0.0.0/16"
  availability_zones  = ["${var.aws_region}a", "${var.aws_region}b"]
  private_subnets     = ["10.0.0.0/20", "10.0.16.0/20"]
  public_subnets      = ["10.0.32.0/20", "10.0.64.0/20"]
  ami                 = "ami-0a5b5c0ea66ec560d"
  instance_type       = "t2.micro"
  key_name            = "mykey"
  key_path            = "~/.aws/pems/mykey.pem"
  create_ec2          = false
}
