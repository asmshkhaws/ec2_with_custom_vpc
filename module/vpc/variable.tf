variable "AWS_REGION" {
    type        = string
    default     = "ap-south-1"
}

variable "asim_vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "asim_public_subnet01_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.101.0/24"
}

variable "asim_public_subnet02_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.102.0/24"
}

# variable "asim_private_subnet01_cidr_block" {
#   description = "The CIDR block for the VPC"
#   type        = string
#   default     = "10.0.1.0/24"
# }

# variable "asim_private_subnet02_cidr_block" {
#   description = "The CIDR block for the VPC"
#   type        = string
#   default     = "10.0.2.0/24"
# }

variable "ENVIRONMENT" {
  description = "AWS VPC Environment Name"
  type        = string
  default     = "Development"
}


