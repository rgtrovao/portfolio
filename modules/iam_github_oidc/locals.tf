locals {
  name_prefix = "${var.project_name}-${var.environment}"

  role_name = coalesce(var.role_name, "${local.name_prefix}-gha-ecr")

  subjects = [
    for ref in var.github_allowed_refs :
    "repo:${var.github_org}/${var.github_repo}:ref:${ref}"
  ]

  common_tags = merge(
    {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "Terraform"
    },
    var.tags
  )
}

