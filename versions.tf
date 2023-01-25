terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
    github = {
      source  = "hashicorp/github"
      version = "2.9.2"
    }
  }
  required_version = "~> 1.0"
}
