output "iam_role_arn" {
  description = "ARN da role IRSA para o AWS Load Balancer Controller."
  value       = aws_iam_role.this.arn
}

output "iam_role_name" {
  description = "Nome da role IRSA."
  value       = aws_iam_role.this.name
}

output "iam_policy_arn" {
  description = "ARN da IAM policy anexada à role."
  value       = aws_iam_policy.controller.arn
}

output "oidc_provider_arn" {
  description = "ARN do IAM OIDC provider do cluster EKS."
  value       = aws_iam_openid_connect_provider.this.arn
}

