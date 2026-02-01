variable "aws_region" {
  description = "Região AWS."
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Nome do projeto."
  type        = string
  default     = "projeto-eks"
}

variable "environment" {
  description = "Nome do ambiente."
  type        = string
  default     = "personal"
}

variable "availability_zones" {
  description = "AZs usadas (2 AZs)."
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "vpc_cidr" {
  description = "CIDR da VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "CIDRs das subnets públicas (2 itens)."
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.4.0/24"]
}

variable "private_subnet_cidrs" {
  description = "CIDRs das subnets privadas (2 itens)."
  type        = list(string)
  default     = ["10.0.2.0/24", "10.0.5.0/24"]
}

variable "db_subnet_cidrs" {
  description = "CIDRs das subnets de banco (2 itens)."
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.6.0/24"]
}

variable "cluster_name" {
  description = "Nome do cluster EKS."
  type        = string
  default     = "projeto-eks-personal"
}

variable "kubernetes_version" {
  description = "Versão do Kubernetes no EKS."
  type        = string
  default     = "1.33"
}

variable "cluster_endpoint_public_access_cidrs" {
  description = "CIDRs permitidos no endpoint público do EKS (recomendado restringir ao seu IP/32)."
  type        = list(string)
  default     = ["0.0.0.0/0"]
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
  default     = 3
}

variable "node_min_size" {
  description = "Tamanho mínimo do node group."
  type        = number
  default     = 3
}

variable "node_max_size" {
  description = "Tamanho máximo do node group."
  type        = number
  default     = 3
}

variable "aws_load_balancer_controller_chart_version" {
  description = "Versão do chart Helm do AWS Load Balancer Controller (repo aws/eks-charts)."
  type        = string
  default     = "3.0.0"
}

variable "aws_load_balancer_controller_replica_count" {
  description = "Número de réplicas do AWS Load Balancer Controller."
  type        = number
  default     = 2
}

variable "ecr_repository_name" {
  description = "Nome do repositório ECR (ex.: projeto-eks/app)."
  type        = string
  default     = "projeto-eks/app"
}

variable "github_org" {
  description = "Org/owner do repositório no GitHub (para OIDC)."
  type        = string
}

variable "github_repo" {
  description = "Nome do repositório no GitHub (para OIDC)."
  type        = string
}

variable "github_allowed_refs" {
  description = "Refs permitidas para o GitHub Actions assumir a role (ex.: refs/heads/main, refs/tags/v*)."
  type        = list(string)
  default     = ["refs/heads/main"]
}

variable "existing_github_oidc_provider_arn" {
  description = "Se já existir um GitHub OIDC Provider na conta, informe o ARN para reutilizar (evita conflito)."
  type        = string
  default     = null
}

