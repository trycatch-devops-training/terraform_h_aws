variable "region" {
  default = "ap-south-1"
}

variable "region1" {
  default = "us-east-1"
}

variable "availability-zone-1a" {
  default = "ap-south-1a"
}

variable "availability-zone-1b" {
  default = "ap-south-1b"
}

variable "availability-zone-1c" {
  default = "ap-south-1c"
}

variable "ami" {
  type = map(any)
  default = {
    ap-south-1 = "ami-0e1d06225679bc1c5"
    us-east-1  = "ami-08a0d1e16fc3f61ea"
  }
}