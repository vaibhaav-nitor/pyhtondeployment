variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "subnet_1_cidr" {
  default = "10.0.1.0/24"
}

variable "subnet_2_cidr" {
  default = "10.0.2.0/24"
}

variable "az_1" {
  default = "us-west-2a"
}

variable "az_2" {
  default = "us-west-2b"
}

variable "ami_id" {
  default = "ami-04c0ab8f1251f1600"  # Replace with a valid AMI ID
}

variable "instance_type" {
  default = "t2.micro"
}
