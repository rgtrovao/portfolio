output "aws_region" {
  description = "Região AWS."
  value       = var.aws_region
}

output "project_name" {
  description = "Nome do projeto."
  value       = var.project_name
}

output "environment" {
  description = "Nome do ambiente."
  value       = var.environment
}

output "network" {
  description = "Outputs consolidados da rede (VPC, subnets, IGW, NAT, route tables)."
  value = {
    vpc_id   = module.vpc.vpc_id
    vpc_name = module.vpc.vpc_name

    igw_id   = module.vpc.igw_id
    igw_name = module.vpc.igw_name

    public_subnet_ids   = module.vpc.public_subnet_ids
    public_subnet_names = module.vpc.public_subnet_names

    private_subnet_ids   = module.vpc.private_subnet_ids
    private_subnet_names = module.vpc.private_subnet_names

    db_subnet_ids   = module.vpc.db_subnet_ids
    db_subnet_names = module.vpc.db_subnet_names

    nat_gw_id             = module.vpc.nat_gw_id
    nat_gw_name           = module.vpc.nat_gw_name
    nat_eip_allocation_id = module.vpc.nat_eip_allocation_id
    nat_eip_name          = module.vpc.nat_eip_name

    public_route_table_id   = module.vpc.public_route_table_id
    public_route_table_name = module.vpc.public_route_table_name

    private_route_table_id   = module.vpc.private_route_table_id
    private_route_table_name = module.vpc.private_route_table_name

    db_route_table_id   = module.vpc.db_route_table_id
    db_route_table_name = module.vpc.db_route_table_name
  }
}

output "eks" {
  description = "Outputs consolidados do EKS (cluster e node group)."
  value = {
    cluster_name              = module.eks.cluster_name
    cluster_arn               = module.eks.cluster_arn
    cluster_endpoint          = module.eks.cluster_endpoint
    cluster_version           = module.eks.cluster_version
    cluster_security_group_id = module.eks.cluster_security_group_id
    cluster_iam_role_arn      = module.eks.cluster_iam_role_arn

    node_group_name = module.eks.node_group_name
    node_group_arn  = module.eks.node_group_arn
    node_role_arn   = module.eks.node_role_arn
  }
}

output "ecr" {
  description = "Outputs consolidados do ECR."
  value = {
    repository_name = module.ecr.repository_name
    repository_arn  = module.ecr.repository_arn
    repository_url  = module.ecr.repository_url
    registry_id     = module.ecr.registry_id
  }
}

output "github_actions" {
  description = "Outputs para integração GitHub Actions (OIDC) -> ECR."
  value = {
    oidc_provider_arn = module.github_oidc_ecr.oidc_provider_arn
    role_arn          = module.github_oidc_ecr.role_arn
    role_name         = module.github_oidc_ecr.role_name
  }
}

output "ecr_repository_url" {
  description = "URL do repositório ECR (conveniência)."
  value       = module.ecr.repository_url
}

output "github_actions_ecr_role_arn" {
  description = "ARN da role do GitHub Actions para push no ECR (conveniência)."
  value       = module.github_oidc_ecr.role_arn
}

output "github_actions_cd_role_arn" {
  description = "ARN da role do GitHub Actions para CD (deploy no EKS)."
  value       = module.github_oidc_cd.role_arn
}

output "aws_load_balancer_controller_irsa_role_arn" {
  description = "ARN da role IRSA do AWS Load Balancer Controller."
  value       = module.irsa_aws_load_balancer_controller.iam_role_arn
}

output "aws_load_balancer_controller_oidc_provider_arn" {
  description = "ARN do IAM OIDC provider do cluster EKS (para IRSA)."
  value       = module.irsa_aws_load_balancer_controller.oidc_provider_arn
}

