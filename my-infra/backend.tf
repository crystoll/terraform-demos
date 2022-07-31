terraform {
  backend "s3" {
    region         = "eu-north-1"
    encrypt        = "true"
    profile        = "terraforming"
    bucket         = "tfstate-dev-20220731110227658600000001"
    key            = "my-infra/terraform.tfstate"
    dynamodb_table = "tfstate-lock-dev"
  }
}

