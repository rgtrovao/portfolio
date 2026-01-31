variable "project_name" {
  description = "Nome do projeto para tags e naming."
  type        = string
}

variable "environment" {
  description = "Nome do ambiente (ex.: personal)."
  type        = string
}

variable "cluster_name" {
  description = "Nome do cluster EKS."
  type        = string
}

variable "kubernetes_version" {
  description = "Versão do Kubernetes no EKS."
  type        = string
  default     = "1.33"
}

variable "subnet_ids" {
  description = "Subnets associadas ao cluster EKS (públicas e privadas; não incluir subnets de banco)."
  type        = list(string)
}

variable "node_subnet_ids" {
  description = "Subnets do node group (recomendado: privadas)."
  type        = list(string)
}

variable "cluster_endpoint_public_access" {
  description = "Permite endpoint público do cluster."
  type        = bool
  default     = true
}

variable "cluster_endpoint_public_access_cidrs" {
  description = "CIDRs permitidos no endpoint público do cluster."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "cluster_endpoint_private_access" {
  description = "Permite endpoint privado do cluster."
  type        = bool
  default     = true
}

variable "node_instance_types" {
  description = "Tipos de instância do node group."
  type        = list(string)
  default     = ["t3.micro"]
}

variable "node_capacity_type" {
  description = "Tipo de capacidade do node group (ON_DEMAND ou SPOT)."
  type        = string
  default     = "SPOT"
}

variable "node_desired_size" {
  description = "Tamanho desejado do node group."
  type        = number
  default     = 2
}

variable "node_min_size" {
  description = "Tamanho mínimo do node group."
  type        = number
  default     = 2
}

variable "node_max_size" {
  description = "Tamanho máximo do node group."
  type        = number
  default     = 2
}

variable "tags" {
  description = "Tags adicionais."
  type        = map(string)
  default     = {}
}

