variable ami_id {
  default = "ami-e659c7f0"
}

variable vpc_id {
  default = "vpc-80ab27e6"
}

variable public_subnet {
  default ="subnet-6f95a026"
}

variable private_subnet {
  default =""
}

variable key_name {
  default = "manvi_trainee"
}

variable security_group {
  default = "sg-806bcbfc"
}

variable instance_type {
  default = "t2.micro"
}

variable az {
  default = "us-east-1b"
}

variable owner {
  default = "manvitha.potluri"
}

variable name {
  default = "suntrust-userdata-test"
}

variable remote_state_bucket {
  default = "manvi-logs"
}

variable remote_state_key {
  default = "tfstate/aj-infra"
}

variable remote_buc_reg {
  default = "us-east-1"
}

variable expiration_date {
  default = "2017-06-06"
}

variable "iamprofile" {
  default = ""
}

variable "Project" {
  default = "suntrust"
}

variable "Environment" {
  default = "Developement"
}

variable "webserver_name" {
  default = "suntrust-windows-2012-r2-2"
}

variable "vpc_cidr_block" {
  default = "192.168.0.0/24"
}