output "repository_name" {
  description = "Nome do repositório ECR."
  value       = aws_ecr_repository.this.name
}

output "repository_arn" {
  description = "ARN do repositório ECR."
  value       = aws_ecr_repository.this.arn
}

output "repository_url" {
  description = "URL do repositório ECR (para docker tag/push e manifests do Kubernetes)."
  value       = aws_ecr_repository.this.repository_url
}

output "registry_id" {
  description = "ID da conta/registry do ECR."
  value       = aws_ecr_repository.this.registry_id
}

