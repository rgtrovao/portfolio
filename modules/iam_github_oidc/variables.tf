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

variable "existing_oidc_provider_arn" {
  description = "Se já existir um OIDC provider do GitHub na conta, informe o ARN para reutilizar (evita conflito)."
  type        = string
  default     = null
}

variable "thumbprint_list" {
  description = "Lista de thumbprints do provider OIDC do GitHub Actions."
  type        = list(string)
  default     = ["6938fd4d98bab03faadb97b34396831e3780aea1"]
}

variable "ecr_repository_arns" {
  description = "Lista de ARNs dos repositórios ECR onde a role pode fazer push/pull."
  type        = list(string)
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

