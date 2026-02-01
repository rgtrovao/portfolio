variable "project_name" {
  description = "Nome do projeto para tags e naming."
  type        = string
}

variable "environment" {
  description = "Nome do ambiente (ex.: personal)."
  type        = string
}

variable "cluster_oidc_issuer_url" {
  description = "OIDC issuer URL do cluster EKS (ex.: https://oidc.eks.us-east-1.amazonaws.com/id/XXXX)."
  type        = string
}

variable "policy_json" {
  description = "JSON da IAM policy do AWS Load Balancer Controller."
  type        = string
}

variable "namespace" {
  description = "Namespace do ServiceAccount do controller."
  type        = string
  default     = "kube-system"
}

variable "serviceaccount_name" {
  description = "Nome do ServiceAccount do controller."
  type        = string
  default     = "aws-load-balancer-controller"
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

