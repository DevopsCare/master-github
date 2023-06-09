variable "org_fqdn" {}
variable "org_rev_fqdn" {}
variable "project_prefix" {}
variable "project_name" {}

variable "github_organization" {}
variable "ci_username" {
  type        = string
  description = "Name of CI account to be added to repos admins. Defaults to Organization github account name from SSM"
  default     = ""
}

variable "github_projects" {
  type = list(string)
}

variable "create_terraform_repo" {
  default = true
}

variable "github_init_repos" {
  default = false
}

variable "github_init_branch" {
  type    = string
  default = "master"
}
