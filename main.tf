provider "aws" {
    region = "us-east-1"
    /*
    assume_role {
        role_arn = module.aws_provider_roles.zimride
    }
    */
}

terraform {
    backend "s3" {}
}