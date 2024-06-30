terraform {
  backend "s3" {
    bucket = "my-bucket-har"
    key    = "developer/terraform.tfstate"
    region = "us-east-1"
  }
}