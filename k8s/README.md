# Kubernetes manifests (portfolio on EKS)

This folder contains the Kubernetes manifests and installation notes to publish a personal portfolio website on your EKS cluster using:
- a custom nginx image built from this repo (2 replicas)
- AWS Load Balancer Controller (ALB Ingress) with HTTP -> HTTPS redirect
- ACM certificate: `arn:aws:acm:us-east-1:575530852213:certificate/66c26371-4863-4b7d-b29d-ed16ea02a28d`
- Host: `www.truecloud.com.br`

## Structure
- `controllers/aws-load-balancer-controller/`: IRSA IAM policy (Terraform) + controller notes
- `apps/portfolio-nginx/`: namespace + deployment + service + ingress

## Deploy (high level)
1. Apply Terraform infra (VPC/EKS/ECR).
2. Terraform also installs AWS Load Balancer Controller automatically.
3. Apply the portfolio app manifests (see `apps/.../README.md`).
4. Create a Route53 record for `www.truecloud.com.br` pointing to the ALB DNS.

