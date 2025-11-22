variable "vpc_id" {
    type = string
}
variable "name" {
    type = string
}
variable "instance_type" {
    type = string
}
variable "subnet_ids" {
    type = list(string)
}
variable "key_name" {
    type = string
  
}
variable "assign_public_ip" {
  type    = bool
  default = false
}