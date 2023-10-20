## Terraform

## What is Terraform?

Terraform is a tool that allows you to define and manage your computer infrastructure as code. It lets you create, update, and delete your infrastructure resources, such as servers, databases, and networks, by writing code rather than clicking through a graphical user interface. This approach, called infrastructure as code (IAC), makes it easier to automate and manage your infrastructure efficiently and consistently, whether you're working in the cloud, on-premises, or in a hybrid environment.

## Why use Terraform?

Terraform Benefits:

Automation: Streamlines infrastructure management <br>
Infrastructure as Code (IAC): Defines infrastructure using code <br>
Multi-Cloud Support: Works across various cloud providers <br>
Consistency: Ensures uniformity in configurations <br>
Scalability: Easily adjusts to changing demands <br>
Modularity: Encourages code reuse and best practices <br>
State Management: Tracks infrastructure changes accurately <br>
Community and Ecosystem: Offers a supportive community and extensive library of resources <br>

## Who is using Terraform?

Terraform is widely used by a diverse range of organizations and professionals in the fields of DevOps, cloud computing, infrastructure management, and more

**Tech Giants**: Microsoft, Google, AWS <br>

**Government and Public Sector**: Government agencies and organizations in the public sector adopt Terraform for secure and compliant infrastructure management

## Downloading and Installing Terraform

**Step 1**: Download Terraform from the website and unzip to get the `terraform.exe` file, move this to the Windows PATH `C:/Windows/System32 `

**Step 2**: Open a GitBash Terminal and type `terraform` then `terraform --version`

### Using Terraform to Start an EC2 Instance on AWS

Create a new file `nano main.tf`

```
# Who is the provider
provider "aws" {


# location of aws
   region = "eu-west-1"

}
# to download required dependencies
# create a service/resource on the cloud - ec2 on AWS

resource "aws_instance" "shaluo-tech254-iac" {
    ami = "ami-0f31088b1d3e180d3"
    instance_type = "t2.micro"
    tags = {
     Name = "shaluo-tech254-iac"
    }
}

```
`terraform init`

`terraform plan`

`terraform apply`

`terraform destroy`











