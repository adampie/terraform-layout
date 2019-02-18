data "terraform_remote_state" "sec" {
  backend = "s3"

  config {
    bucket   = "example-terraform-remotestate-security"
    key      = "kms.tfstate"
    region   = "eu-west-1"
    role_arn = "arn:aws:iam::00000000000:role/OrganizationAccountAccessRole"
  }
}
