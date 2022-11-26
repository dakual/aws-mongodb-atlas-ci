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
  region  = var.AWS_REGION
}

provider "mongodbatlas" {
  public_key  = var.ATLAS_PUB_KEY
  private_key = var.ATLAS_PRIV_KEY
}

locals {
  name                = "test"
  environment         = "dev"
  cidr                = "10.0.0.0/16"
  availability_zones  = ["${var.AWS_REGION}a", "${var.AWS_REGION}b"]
  private_subnets     = ["10.0.0.0/20", "10.0.16.0/20"]
  public_subnets      = ["10.0.32.0/20", "10.0.64.0/20"]
  ami                 = "ami-0a5b5c0ea66ec560d"
  instance_type       = "t2.micro"
  key_name            = "mykey"
  key_path            = "~/.aws/pems/mykey.pem"
  create_ec2          = false
}
