terraform {
  backend "s3" {
    bucket = "my-tf-state-bucket-48877717" # Replace with your exact bucket name from Step 3
    key    = "prod/terraform.tfstate"
    region = "ap-southeast-1"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ap-southeast-1"
}

resource "aws_ecr_repository" "app_repo" {
  name                 = "my-secure-app-repo"
  image_tag_mutability = "MUTABLE"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"
  name    = "my-vpc"
  cidr    = "10.0.0.0/16"
  azs     = ["ap-southeast-1a", "ap-southeast-1b"]
  public_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
}

resource "aws_ecs_cluster" "main_cluster" {
  name = "my-app-cluster"
}