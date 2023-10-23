# Who is the provider
provider "aws" {
# location of aws
   region = var.aws-region
}
# Create a VPC
resource "aws_vpc" "shaluo_vpc2" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name ="shaluo-terraform-vpc"
  }
}

# Create a public subnet
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.shaluo_vpc2.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "eu-west-1a"
  map_public_ip_on_launch = true
}

# Create a private subnet
resource "aws_subnet" "private_subnet" {
  vpc_id                  = aws_vpc.shaluo_vpc2.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "eu-west-1b"
  map_public_ip_on_launch = false
}

resource "aws_internet_gateway" "shaluo_my_igw" {
  vpc_id = aws_vpc.shaluo_vpc2.id

  tags = {
    Name = "shaluo-terraform-igw"
  }
}

resource "aws_route_table" "shaluo_public_route_table" {
  vpc_id = aws_vpc.shaluo_vpc2.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.shaluo_my_igw.id
  }

  tags = {
    Name = "shaluo-terraform-public-route-table"
  }
}

resource "aws_route_table_association" "public_rta" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.shaluo_public_route_table.id
}

resource "aws_network_acl" "shaluo_my_nacl" {
  vpc_id = aws_vpc.shaluo_vpc2.id

  egress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  ingress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name = "shaluo-terraform-nacl"
  }
}

resource "aws_security_group" "app_sg" {
  vpc_id = aws_vpc.shaluo_vpc2.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Custom TCP Port 3000"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "shaluo-terraform-app-sg"
  }
}

resource "aws_security_group" "db_sg" {
  vpc_id = aws_vpc.shaluo_vpc2.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Custom TCP Port 27017"
    from_port   = 27017
    to_port     = 27017
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "shaluo-terraform-db-sg"
  }
}

resource "aws_instance" "my_ec2" {
  ami                     = var.web-app_ami_id   #"ami-0943382e114f188e8"
  instance_type           = "t2.micro"
  subnet_id               = aws_subnet.public_subnet.id
  vpc_security_group_ids  = [aws_security_group.app_sg.id]

  tags = {
    Name = "shaluo-terraform-test-ec2"
  }
}
# to download required dependencies
# create a service/resource on the cloud - ec2 on AWS

#resource "aws_instance" "shaluo-tech254-iac" {
#    ami = var.web-app_ami_id
#    instance_type = "t2.micro"
#    tags = {
#     Name = "shaluo-tech254-iac"
#    }
#}

