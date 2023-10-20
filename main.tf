# Who is the provider
provider "aws" {


# location of aws
   region = var.aws-region #"eu-west-1"
 
}
# to download required dependencies
# create a service/resource on the cloud - ec2 on AWS

resource "aws_instance" "shaluo-tech254-iac" {
    ami = var.web-app_ami_id #"ami-0f31088b1d3e180d3"
    instance_type = "t2.micro"
    tags = {
     Name = "shaluo-tech254-iac"
    }
}
