terraform {
  cloud {
    organization = "dwashington100292"

    workspaces {
      name = "terra-house-1"
    }
  }

  required_providers {
    random = {
      source = "hashicorp/random"
      version = "3.5.1"
    }
    aws = {
    source = "hashicorp/aws"
    version = "5.19.0"
    }
  }
}


provider "aws" {
  # Configuration options
}
provider "random" {
  # Configuration options
}

# https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string
resource "random_string" "bucket_name" {
  length           = 32
  special          = false
  lower            = true
  upper            = false
}

resource "aws_s3_bucket" "example" {
  # Bucket naming rules
  # https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucketnamingrules.html
  # https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket
  bucket = random_string.bucket_name.result
}


output "random_bucket_name_result" {
  value = random_string.bucket_name.result
}
