terraform {
  backend "s3" {
    bucket         = "innovatemart-bedrock-tfstate-1758197320"
    key            = "project-bedrock/infra/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "innovatemart-bedrock-tflocks" # CI-safe locking
    encrypt        = true
  }
}
