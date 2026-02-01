# Portfolio website (nginx) on EKS

This app publishes a **personal portfolio website** (HTML/CSS/JS) using:
- a custom nginx image built from this repo and pushed to ECR
- 2 replicas
- AWS ALB Ingress with HTTP -> HTTPS redirect
- Host: `www.truecloud.com.br`
- ACM cert: `arn:aws:acm:us-east-1:575530852213:certificate/66c26371-4863-4b7d-b29d-ed16ea02a28d`

Sensitive/identifiable values are **masked** in the website content.

## Files
- `00-namespace.yaml`: Namespace `portfolio`
- `10-deployment.yaml`: nginx deployment (2 pods)
- `20-service.yaml`: ClusterIP service
- `30-ingress-alb.yaml`: ALB Ingress with redirect + HTTPS

## Container image
The website content lives in:
- `site/` (index.html/styles.css/app.js)
- `Dockerfile`

The Deployment uses the ECR image:
- `575530852213.dkr.ecr.us-east-1.amazonaws.com/projeto-eks/app:latest`

## Deploy (manual) — step-by-step

### 1) Provision infrastructure (Terraform)
From repo root:

```bash
cd environments/personal
terraform init -upgrade
terraform apply
```

### 2) Configure `kubectl` for the cluster
```bash
aws eks update-kubeconfig --region us-east-1 --name projeto-eks-personal
```

Wait until the controller is running (Terraform installs it automatically):
```bash
kubectl -n kube-system get deploy aws-load-balancer-controller
kubectl -n kube-system get pods -l app.kubernetes.io/name=aws-load-balancer-controller
```

### 3) Apply the portfolio manifests (single command)
From repo root:

```bash
kubectl apply -f k8s/apps/portfolio-nginx/
```

Validate:

```bash
kubectl -n portfolio get pods
kubectl -n portfolio get svc
kubectl -n portfolio get ingress
```

### 4) Update the website (after CI pushes a new image)
The Deployment uses the `:latest` tag. After a new push, restart the pods to pull the newest image:

```bash
kubectl -n portfolio rollout restart deploy/portfolio-nginx
```

### 5) Create Route53 record (manual)
When the Ingress is ready, it will show an ALB DNS name in `ADDRESS`.

Create a DNS record pointing `www.truecloud.com.br` to the ALB DNS name:
- Route53 Hosted Zone: `truecloud.com.br`
- Record: `www.truecloud.com.br`
- Target: ALB DNS

### 6) Test HTTP -> HTTPS redirect
```bash
curl -I http://www.truecloud.com.br
curl -I https://www.truecloud.com.br
```

Expected:
- `http://...` returns `301/308` redirecting to `https://...`
- `https://...` returns `200`

## Rollback (use a versioned ECR tag)
Images are also pushed with the commit SHA tag (`${{ github.sha }}`) to keep history and enable rollback.

To rollback, edit `10-deployment.yaml` and change:
- from `...:latest`
- to `...:<sha>`

Then apply:

```bash
kubectl apply -f k8s/apps/portfolio-nginx/10-deployment.yaml
```

## Notes
- If the ALB does not get created, it is almost always because the controller is missing, lacks IAM permissions (IRSA), or cannot discover subnets.
  In this repo, the controller should be created by **Terraform** (Helm + IRSA). If it's missing, re-run `terraform apply` and verify the Helm release.
