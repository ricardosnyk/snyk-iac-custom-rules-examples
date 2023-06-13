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

resource "aws_vpc" "valid" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    name = "cloudbank-fix"
  }
}

resource "aws_vpc" "valid2" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    name = "prod-vpc"
  }
}

resource "aws_flow_log" "valid2" {
  iam_role_arn    = aws_iam_role.example.arn
  log_destination = aws_cloudwatch_log_group.example.arn
  traffic_type    = "ALL"
  vpc_id          = aws_vpc.valid2.id
}



resource "aws_vpc" "invalid" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    name = "prod-vpc"
  }

}