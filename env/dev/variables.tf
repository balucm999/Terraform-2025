variable "region" {
    type = string
}
variable "name" {
    type = string
}
variable "availability_zones" {
    type = list(string)
}
variable "cidr_block" {
    type = string
}
variable "private_subnets" {
    type = list(string)
}
variable "public_subnets" {
    type = list(string)
}
variable "name_bastion" {
    type = string  
}
variable "instance_type" {
    type = string
}
variable "key_name" {
    type = string
}
variable "assign_public_ip_bastion" {
  type    = bool
  default = false
}

variable "assign_public_ip_private_ec2" {
  type    = bool
  default = false
}
variable "name_ec2" {
    type =string
}