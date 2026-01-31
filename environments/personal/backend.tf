terraform {
  backend "s3" {
    bucket  = "rgtrovao-terraform-bucket"
    key     = "projeto-eks/personal/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}

