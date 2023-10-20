# Who is the provider
provider "aws" {


# location of aws
   region = var.aws-region
 
}
# to download required dependencies
# create a service/resource on the cloud - ec2 on AWS

resource "aws_instance" "shaluo-tech254-iac" {
    ami = var.web-app_ami_id
    instance_type = "t2.micro"
    tags = {
     Name = "shaluo-tech254-iac"
    }
}
