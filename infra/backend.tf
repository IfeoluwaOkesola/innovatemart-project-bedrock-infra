terraform {
  backend "s3" {
    bucket        = "innovatemart-bedrock-tfstate-1758197320"
    key           = "project-bedrock/infra/terraform.tfstate"
    region        = "eu-west-1"
    use_lockfile  = true
  }
}
