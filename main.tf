module "asim-vpc" {
    source      = "./module/vpc"

    ENVIRONMENT = var.ENVIRONMENT
    AWS_REGION  = var.AWS_REGION
}

module "asim-webserver" {
    source      = "./webserver"

    ENVIRONMENT = var.ENVIRONMENT
    AWS_REGION  = var.AWS_REGION
    # vpc_private_subnet1 = module.asim-vpc.private_subnet1_id
    # vpc_private_subnet2 = module.asim-vpc.private_subnet2_id
    vpc_id = module.asim-vpc.my_vpc_id
    vpc_public_subnet1 = module.asim-vpc.public_subnet1_id
    vpc_public_subnet2 = module.asim-vpc.public_subnet2_id

}

#Define Provider
provider "aws" {
  access_key = var.AWS_ACCESS_KEY
  secret_key = var.AWS_SECRET_KEY
  region     = var.AWS_REGION
}
