# Ambiente `personal`

Este diretório compõe o ambiente **personal** usando os módulos em `../../modules`.

## Arquivos
- `backend.tf`: backend remoto S3 (`rgtrovao-terraform-bucket`).
- `providers.tf`: provider AWS e tags padrão.
- `versions.tf`: versões mínimas do Terraform/provider.
- `variables.tf`: parâmetros do ambiente (CIDRs, AZs, cluster, node group).
- `main.tf`: instancia `module.vpc`, `module.eks`, `module.ecr` e `module.github_oidc_ecr`.
- `outputs.tf`: outputs consolidados (rede + EKS + ECR + GitHub OIDC).

## Execução (manual)
```bash
terraform init
terraform plan
terraform apply
```

## Dicas
- Para reduzir exposição do endpoint do EKS, ajuste `cluster_endpoint_public_access_cidrs` para o seu IP/32.
- NAT Gateway tem custo fixo/hora; se não precisar de saída para internet na subnet privada (ou puder usar endpoints), considere evoluções futuras.
- Para habilitar GitHub Actions (OIDC) -> ECR, defina `github_org` e `github_repo` (e opcionalmente ajuste `github_allowed_refs`).

## Variáveis obrigatórias já preenchidas
Este diretório contém `terraform.tfvars` com:
- `github_org = "rgtrovao"`
- `github_repo = "portfolio"`

