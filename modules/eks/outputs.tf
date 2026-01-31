output "cluster_name" {
  description = "Nome do cluster EKS."
  value       = aws_eks_cluster.this.name
}

output "cluster_arn" {
  description = "ARN do cluster EKS."
  value       = aws_eks_cluster.this.arn
}

output "cluster_endpoint" {
  description = "Endpoint do cluster EKS."
  value       = aws_eks_cluster.this.endpoint
}

output "cluster_version" {
  description = "Versão do Kubernetes no EKS."
  value       = aws_eks_cluster.this.version
}

output "cluster_security_group_id" {
  description = "Security Group gerenciado pelo EKS para o cluster."
  value       = aws_eks_cluster.this.vpc_config[0].cluster_security_group_id
}

output "cluster_iam_role_arn" {
  description = "ARN da role IAM do cluster."
  value       = aws_iam_role.eks_cluster.arn
}

output "node_group_name" {
  description = "Nome do managed node group."
  value       = aws_eks_node_group.this.node_group_name
}

output "node_group_arn" {
  description = "ARN do managed node group."
  value       = aws_eks_node_group.this.arn
}

output "node_role_arn" {
  description = "ARN da role IAM dos nodes."
  value       = aws_iam_role.node.arn
}

