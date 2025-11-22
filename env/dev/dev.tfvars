region = "us-east-1"
name = "dev_vpc"
availability_zones = [ "ap-south-1a","ap-south-1b" ]
cidr_block = "10.0.0.0/16"
private_subnets = [ "10.0.1.0/24","10.0.2.0/24" ]
public_subnets = [ "10.0.3.0/24","10.0.4.0/24" ]
assign_public_ip_bastion = true
assign_public_ip_private_ec2 = false

