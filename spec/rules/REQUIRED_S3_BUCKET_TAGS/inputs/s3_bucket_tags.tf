provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "valid" {
  bucket = "valid-bucket"

  tags = {
    owner           = "devteam1"
    classification  = "public"
  }
}

resource "aws_s3_bucket" "invalid" {
  bucket = "invalid-bucket"

  tags = {
    owner           = "devteam5"
    classification  = "available"
  }
}