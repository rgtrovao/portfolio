variable "project_name" {
  description = "Nome do projeto para tags e naming."
  type        = string
}

variable "environment" {
  description = "Nome do ambiente (ex.: personal)."
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR da VPC."
  type        = string
}

variable "availability_zones" {
  description = "Lista de AZs usadas. Esperado 2 AZs (ex.: us-east-1a e us-east-1b)."
  type        = list(string)

  validation {
    condition     = length(var.availability_zones) == 2
    error_message = "availability_zones deve ter exatamente 2 AZs."
  }
}

variable "public_subnet_cidrs" {
  description = "Lista de CIDRs das subnets públicas (2 itens)."
  type        = list(string)

  validation {
    condition     = length(var.public_subnet_cidrs) == 2
    error_message = "public_subnet_cidrs deve ter exatamente 2 CIDRs."
  }
}

variable "private_subnet_cidrs" {
  description = "Lista de CIDRs das subnets privadas (2 itens)."
  type        = list(string)

  validation {
    condition     = length(var.private_subnet_cidrs) == 2
    error_message = "private_subnet_cidrs deve ter exatamente 2 CIDRs."
  }
}

variable "db_subnet_cidrs" {
  description = "Lista de CIDRs das subnets de banco (2 itens)."
  type        = list(string)

  validation {
    condition     = length(var.db_subnet_cidrs) == 2
    error_message = "db_subnet_cidrs deve ter exatamente 2 CIDRs."
  }
}

variable "tags" {
  description = "Tags adicionais."
  type        = map(string)
  default     = {}
}
