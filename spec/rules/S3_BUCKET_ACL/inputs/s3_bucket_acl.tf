# © 2023 Snyk Limited All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "valid" {
  bucket = "my-tf-valid-bucket"
}

resource "aws_s3_bucket_ownership_controls" "valid" {
  bucket = aws_s3_bucket.valid.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "valid" {
  depends_on = [aws_s3_bucket_ownership_controls.valid]

  bucket = aws_s3_bucket.valid.id
  acl    = "private"
}

resource "aws_s3_bucket" "invalid" {
  bucket = "my-invalid-tf-bucket"
}

resource "aws_s3_bucket_ownership_controls" "invalid" {
  bucket = aws_s3_bucket.invalid.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "invalid" {
  bucket = aws_s3_bucket.invalid.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "invalid" {
  depends_on = [
    aws_s3_bucket_ownership_controls.invalid,
    aws_s3_bucket_public_access_block.invalid,
  ]

  bucket = aws_s3_bucket.invalid.id
  acl    = "public-read"
}