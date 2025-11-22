provider "AWS" {
    region = var.region
  
}
module "vpc" {
    name = var.name
    source = "../../Modules-2025/AWS-VPC"
    cidr_block = var.cidr_block
    availability_zones = var.availability_zones
    private_subnets = var.private_subnets
    public_subnets = var.public_subnets
}

module "bastion" {
    source = "../../Modules-2025/AWS_ec2"
    name = var.name_bastion
    vpc_id = module.vpc.vpc_id
    instance_type = var.instance_type
    assign_public_ip = var.assign_public_ip_bastion
    key_name = var.key_name
    subnet_ids = module.vpc.public_subnets_ids
}
module "private_ec2" {
    source = "../../Modules-2025/AWS_ec2"
    name = var.name_ec2
    vpc_id = module.vpc.vpc_id
    instance_type = var.instance_type
    assign_public_ip = var.assign_public_ip_private_ec2
    key_name = var.key_name
    subnet_ids = module.vpc.private_subnets_ids
}