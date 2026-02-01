module "vpc" {
  source = "../../modules/vpc"

  project_name = var.project_name
  environment  = var.environment

  vpc_cidr             = var.vpc_cidr
  availability_zones   = var.availability_zones
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  db_subnet_cidrs      = var.db_subnet_cidrs
}

module "eks" {
  source = "../../modules/eks"

  project_name = var.project_name
  environment  = var.environment

  cluster_name       = var.cluster_name
  kubernetes_version = var.kubernetes_version

  subnet_ids      = concat(module.vpc.public_subnet_ids, module.vpc.private_subnet_ids)
  node_subnet_ids = module.vpc.private_subnet_ids

  cluster_endpoint_public_access_cidrs = var.cluster_endpoint_public_access_cidrs

  node_instance_types = var.node_instance_types
  node_capacity_type  = var.node_capacity_type
  node_desired_size   = var.node_desired_size
  node_min_size       = var.node_min_size
  node_max_size       = var.node_max_size
}

module "ecr" {
  source = "../../modules/ecr"

  project_name = var.project_name
  environment  = var.environment

  repository_name = var.ecr_repository_name

  # The repository itself is created manually (Console) to preserve image history.
  # Terraform still manages lifecycle policy to control retention/cost.
  lifecycle_max_image_count = var.ecr_lifecycle_max_image_count
}

module "github_oidc_ecr" {
  source = "../../modules/iam_github_oidc"

  project_name = var.project_name
  environment  = var.environment

  github_org          = var.github_org
  github_repo         = var.github_repo
  github_allowed_refs = var.github_allowed_refs

  existing_oidc_provider_arn = var.existing_github_oidc_provider_arn

  ecr_repository_arns = [module.ecr.repository_arn]
}

module "github_oidc_cd" {
  source = "../../modules/iam_github_oidc_cd"

  project_name = var.project_name
  environment  = var.environment

  github_org          = var.github_org
  github_repo         = var.github_repo
  github_allowed_refs = var.github_allowed_refs

  # Reuse the same GitHub OIDC provider (avoid conflicts).
  oidc_provider_arn = module.github_oidc_ecr.oidc_provider_arn

  eks_cluster_arn = module.eks.cluster_arn
}

module "irsa_aws_load_balancer_controller" {
  source = "../../modules/irsa_aws_load_balancer_controller"

  project_name = var.project_name
  environment  = var.environment

  cluster_oidc_issuer_url = module.eks.cluster_oidc_issuer_url
  policy_json             = file("${path.root}/../../k8s/controllers/aws-load-balancer-controller/iam-policy.json")

  namespace           = "kube-system"
  serviceaccount_name = "aws-load-balancer-controller"
}

resource "aws_eks_access_entry" "github_actions_cd" {
  cluster_name  = module.eks.cluster_name
  principal_arn = module.github_oidc_cd.role_arn
  type          = "STANDARD"
}

resource "aws_eks_access_policy_association" "github_actions_cd_admin" {
  cluster_name  = module.eks.cluster_name
  principal_arn = module.github_oidc_cd.role_arn
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"

  access_scope {
    type = "cluster"
  }

  depends_on = [aws_eks_access_entry.github_actions_cd]
}

resource "helm_release" "aws_load_balancer_controller" {
  name       = "aws-load-balancer-controller"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  version    = var.aws_load_balancer_controller_chart_version

  namespace        = "kube-system"
  create_namespace = false

  values = [
    yamlencode({
      clusterName  = module.eks.cluster_name
      region       = var.aws_region
      vpcId        = module.vpc.vpc_id
      replicaCount = var.aws_load_balancer_controller_replica_count

      serviceAccount = {
        create = true
        name   = "aws-load-balancer-controller"
        annotations = {
          "eks.amazonaws.com/role-arn" = module.irsa_aws_load_balancer_controller.iam_role_arn
        }
      }
    })
  ]

  depends_on = [
    module.irsa_aws_load_balancer_controller,
    aws_eks_access_policy_association.github_actions_cd_admin,
  ]
}

