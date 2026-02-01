locals {
  name_prefix = "${var.project_name}-${var.environment}"
  role_name   = var.role_name != null ? var.role_name : "${local.name_prefix}-gha-cd"

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

