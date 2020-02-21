data "aws_ssm_parameter" "github_username" {
  name = "${var.org_rev_fqdn}.terraform.github-ci.username"
}
data "aws_ssm_parameter" "github_token" {
  name = "${var.org_rev_fqdn}.terraform.github-token"
}

provider "github" {
  token        = data.aws_ssm_parameter.github_token.value
  organization = var.github_organization
}
