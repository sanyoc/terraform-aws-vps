# Create a VPC
resource "aws_vpc" "example" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true
}

resource "aws_subnet" "public_subnets" {
  depends_on = [
    aws_vpc.example
  ]
  vpc_id             = aws_vpc.example.id
  cidr_block         = "10.0.1.0/24"
  availability_zone = data.aws_availability_zones.available.names[0]
    #for_each = toset(data.aws_availability_zones.available.names)
}

resource "aws_iam_user" "lb" {
  for_each = toset(var.users)
  name = each.value
}
