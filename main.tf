terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.35"
    }
  }
}

terraform {
  backend "s3" {
    bucket = "gamex-terraform-s3-bucket"
    key    = "gamex-terraform.tfstate"
    region = var.region
  }
}

provider "aws" {
    region = var.region
    profile = var.profile
   
}

module "vpc" {
    source = "./modules/vpc"

    cidr = "10.0.0.0/16"

    az   = "us-east-1a"
    public_subnet      =["10.0.1.0/24", "10.0.3.0/24"]
    private_subnet       ="10.0.101.0/24"

    tags = {
      Name = "gamex-vpc"
      Terraform = "true"
    }
}

module "ec2" {
    source  = "./modules/ec2"

    instance_type       = "t2.medium"
    key_name            = "mukesh"
    ami_id              = "ami-053b0d53c279acc90"
    security_group_id   = module.vpc.security-group-id
    private_subnet_id   = module.vpc.private-subnet-id
    public_subnet_id    = module.vpc.public-subnet-id
    instance_profile    = module.iam.iam_instance_profile  
}

module "iam" {
  source = "./modules/iam"
}