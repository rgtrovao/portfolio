output "role_arn" {
  description = "ARN da role assumida pelo GitHub Actions via OIDC (CD)."
  value       = aws_iam_role.this.arn
}

output "role_name" {
  description = "Nome da role IAM (CD)."
  value       = aws_iam_role.this.name
}

output "oidc_provider_arn" {
  description = "ARN do OIDC provider usado (criado ou reutilizado)."
  value       = var.oidc_provider_arn
}

