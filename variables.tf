variable "aws_region" {}
variable "org_fqdn" {}
variable "org_rev_fqdn" {}
variable "project_prefix" {}
variable "project_name" {}

variable "github_organization" {}
variable "ci_username" {}

variable "github_projects" {
  type = "list"
}
