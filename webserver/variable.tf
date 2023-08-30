variable "PATH_TO_PUBLIC_KEY" {
    default = "./asim_key.pub"
}

variable "AWS_REGION" {
    default = "ap-south-1"
}

variable "AMI" {
    type = map
    default = {
        ap-south-1 = "ami-06f621d90fa29f6d0"
        us-east-1 = "ami-051f7e7f6c2f40dc1"
    }
}

variable "instance_type" {
    default = "t2.micro"
}

variable "ENVIRONMENT" {
    default = "Devolopment"
}

variable "INSTANCE_USERNAME" {
    default = "ubuntu"
}

variable "PATH_TO_PRIVATE_KEY" {
    default = "./asim_key"
}
