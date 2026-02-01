variable "project_name" {
  description = "Nome do projeto para tags e naming."
  type        = string
}

variable "environment" {
  description = "Nome do ambiente (ex.: personal)."
  type        = string
}

variable "github_org" {
  description = "Org/owner do repositório no GitHub."
  type        = string
}

variable "github_repo" {
  description = "Nome do repositório no GitHub."
  type        = string
}

variable "github_allowed_refs" {
  description = "Lista de refs permitidas para assumir a role (ex.: refs/heads/main, refs/tags/v*)."
  type        = list(string)
  default     = ["refs/heads/main"]
}

variable "oidc_provider_arn" {
  description = "ARN do GitHub OIDC provider (token.actions.githubusercontent.com). Deve ser criado/gerenciado fora deste módulo."
  type        = string
}

variable "eks_cluster_arn" {
  description = "ARN do cluster EKS (usado para permitir DescribeCluster)."
  type        = string
}

variable "role_name" {
  description = "Nome opcional da role IAM (se null, usa um nome padrão)."
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags adicionais."
  type        = map(string)
  default     = {}
}

