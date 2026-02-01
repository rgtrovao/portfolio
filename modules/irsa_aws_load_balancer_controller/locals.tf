locals {
  name_prefix = "${var.project_name}-${var.environment}"

  role_name = coalesce(var.role_name, "${local.name_prefix}-irsa-aws-load-balancer-controller")

  issuer_hostpath = replace(var.cluster_oidc_issuer_url, "https://", "")

  common_tags = merge(
    {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "Terraform"
    },
    var.tags
  )
}

