variable "env" {}
variable "vpc_cidr" {}

data "aws_availability_zones" "az" {}

resource "aws_vpc" "vpc" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags {
    name = "desarrollo-${var.env}-vpc"
  }
}

resource "aws_subnet" "subnet" {
  cidr_block        = "${cidrsubnet(aws_vpc.vpc.cidr_block, 4, 0)}"
  availability_zone = "${data.aws_availability_zones.az.names[0]}"
  vpc_id            = "${aws_vpc.vpc.id}"

  tags {
    name = "desarrollo-${var.env}-subnet"
  }
}

resource "aws_internet_gateway" "gateway" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    name = "desarrollo-${var.env}-ig"
  }
}

resource "aws_route_table" "route_table" {
  vpc_id = "${aws_vpc.vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gateway.id}"
  }

  tags {
    name = "desarrollo-${var.env}-rt"
  }
}

resource "aws_route_table_association" "route_association" {
  subnet_id      = "${aws_subnet.subnet.id}"
  route_table_id = "${aws_route_table.route_table.id}"
}

resource "aws_security_group" "security_group_desarrollo" {
  name        = "sg_desarrollo_service"
  description = "services traffic"
  vpc_id      = "${aws_vpc.vpc.id}"

  tags {
    name = "desarrollo-${var.env}-sg"
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }
}

output "vpc_id" {
  value = "${aws_vpc.vpc.id}"
}

output "vpc_cidr" {
  value = "${aws_vpc.vpc.cidr_block}"
}

output "subnet_id" {
  value = "${aws_subnet.subnet.id}"
}

output "security_group_id" {
  value = "${aws_security_group.security_group_desarrollo.id}"
}
