# Ambiente `personal`

Este diretório compõe o ambiente **personal** usando os módulos em `../../modules`.

## Arquivos
- `backend.tf`: backend remoto S3 (`rgtrovao-terraform-bucket`).
- `providers.tf`: providers AWS/Kubernetes/Helm (Kubernetes/Helm apontam para o cluster EKS).
- `versions.tf`: versões mínimas do Terraform/provider.
- `variables.tf`: parâmetros do ambiente (CIDRs, AZs, cluster, node group).
- `main.tf`: instancia `module.vpc`, `module.eks`, `module.ecr`, `module.github_oidc_ecr`, IRSA do controller e instala o AWS Load Balancer Controller via Helm.
- `outputs.tf`: outputs consolidados (rede + EKS + ECR + GitHub OIDC).

## Execução (manual)
```bash
terraform init -upgrade
terraform apply
```

## Dicas
- Para reduzir exposição do endpoint do EKS, ajuste `cluster_endpoint_public_access_cidrs` para o seu IP/32.
- NAT Gateway tem custo fixo/hora; se não precisar de saída para internet na subnet privada (ou puder usar endpoints), considere evoluções futuras.
- Para habilitar GitHub Actions (OIDC) -> ECR, defina `github_org` e `github_repo` (e opcionalmente ajuste `github_allowed_refs`).

## Variáveis (GitHub OIDC → ECR)
Este diretório contém um exemplo versionado:
- `terraform.tfvars.example`

Crie seu arquivo local (não commitado) a partir dele:
```bash
cp terraform.tfvars.example terraform.tfvars
```

