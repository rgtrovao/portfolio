variable "project_name" {
  description = "Nome do projeto para tags e naming."
  type        = string
}

variable "environment" {
  description = "Nome do ambiente (ex.: personal)."
  type        = string
}

variable "repository_name" {
  description = "Nome do repositório ECR (ex.: projeto-eks/app)."
  type        = string
}

variable "image_tag_mutability" {
  description = "Mutabilidade das tags (MUTABLE ou IMMUTABLE)."
  type        = string
  default     = "MUTABLE"
}

variable "scan_on_push" {
  description = "Habilita scan de vulnerabilidades no push."
  type        = bool
  default     = true
}

variable "encryption_type" {
  description = "Tipo de criptografia do ECR (AES256 ou KMS)."
  type        = string
  default     = "AES256"
}

variable "enable_lifecycle_policy" {
  description = "Habilita lifecycle policy para expirar imagens antigas."
  type        = bool
  default     = true
}

variable "lifecycle_max_image_count" {
  description = "Quantidade máxima de imagens para manter quando lifecycle policy estiver habilitada."
  type        = number
  default     = 30
}

variable "tags" {
  description = "Tags adicionais."
  type        = map(string)
  default     = {}
}

