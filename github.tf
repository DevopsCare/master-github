data "aws_ssm_parameter" "github_token" {
  name = "${var.org_rev_fqdn}.terraform.github-token"
}

provider "github" {
  token        = "${data.aws_ssm_parameter.github_token.value}"
  organization = "${var.github_organization}"
}

resource "github_repository" "repo" {
  count       = "${length(var.github_projects)}"
  name        = "${var.project_prefix}-${element(var.github_projects, count.index)}"
  description = "\"${var.project_name}\" ${element(var.github_projects, count.index)} repository"

  private            = true
  has_issues         = false
  has_wiki           = false
  has_projects       = false
  auto_init          = true
  gitignore_template = "Java"
}

resource "github_team" "admins" {
  name        = "${var.project_prefix}-admins"
  description = "${var.project_name} administrators with full access to repos"
  privacy     = "closed"
}

resource "github_team" "devs" {
  name        = "${var.project_prefix}-developers"
  description = "${var.project_name} developers with usual read-write access to repos"
  privacy     = "closed"
}

resource "github_team_membership" "ci-account" {
  team_id  = "${github_team.admins.id}"
  username = "${var.ci_username}"
  role     = "member"
}

resource "github_team_repository" "repo-admins" {
  count      = "${length(var.github_projects)}"
  team_id    = "${github_team.admins.id}"
  repository = "${element(github_repository.repo.*.name, count.index)}"
  permission = "admin"
}

resource "github_team_repository" "repo-devs" {
  count      = "${length(var.github_projects)}"
  team_id    = "${github_team.devs.id}"
  repository = "${element(github_repository.repo.*.name, count.index)}"
  permission = "push"
}

resource "github_branch_protection" "master" {
  count          = "${length(var.github_projects)}"
  repository     = "${element(github_repository.repo.*.name, count.index)}"
  branch         = "master"
  enforce_admins = false
}
