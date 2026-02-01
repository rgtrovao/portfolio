# AWS Load Balancer Controller (ALB Ingress)

This project uses an **ALB Ingress** to provide:
- Internet-facing access
- HTTP (80) -> HTTPS (443) redirect
- ACM TLS termination

To make this work on EKS, you must install the **AWS Load Balancer Controller**.

## Current approach in this repo (recommended)
The controller is installed **automatically by Terraform** (Helm release), including:
- IRSA (OIDC provider + IAM role/policy)
- ServiceAccount annotations (`eks.amazonaws.com/role-arn`)
- Deployment/RBAC resources

So you **do not** need to run Helm manually, and you **should not** apply controller manifests with `kubectl` from this folder.

## Files in this folder
- `iam-policy.json`: IAM policy document used by Terraform to create the IRSA policy.
- `values.yaml`: reference only (Terraform sets values directly; you can use this if you ever decide to install manually).

## Validate (after `terraform apply`)
```bash
kubectl -n kube-system get deploy aws-load-balancer-controller
kubectl -n kube-system get pods -l app.kubernetes.io/name=aws-load-balancer-controller
```

