# Deploy & Destroy Runbook (`projeto-eks`)

This repo is designed for a simple workflow:

- **1x `terraform apply`**: provisions AWS infra + installs AWS Load Balancer Controller (Helm + IRSA)
- **1x `kubectl apply -f`**: deploys the portfolio app (nginx + Ingress)

## Prerequisites

- AWS CLI authenticated to account `575530852213`
- Terraform `>= 1.5`
- `kubectl`
- (Optional) `helm` (not required for normal provisioning; Terraform installs the chart)

## Provision (from scratch)

### 1) Terraform apply

```bash
cd environments/personal
terraform init -upgrade
terraform apply
```

Notes:
- `-upgrade` keeps `.terraform.lock.hcl` consistent when providers are added/updated.
- The Terraform backend is S3: `rgtrovao-terraform-bucket` (no DynamoDB locking by design).

## CI (build & push to ECR)

This repo includes a GitHub Actions workflow:
- `.github/workflows/build-and-push.yml`

Configure these GitHub Secrets:
- `AWS_ROLE_ARN` (Terraform output: `github_actions_ecr_role_arn`)
- `AWS_CD_ROLE_ARN` (Terraform output: `github_actions_cd_role_arn`)
- `ECR_REPOSITORY_URL` (Terraform output: `ecr_repository_url`)

Each push to `main` publishes two tags to ECR:
- `:latest` (used by the Kubernetes Deployment)
- `:${{ github.sha }}` (versioned history for rollback)

## CD (deploy to EKS)

The same workflow includes a `deploy` job that:
- configures kubectl for the cluster
- runs `kubectl -n portfolio rollout restart deploy/portfolio-nginx`

This keeps the deploy flow simple while still being fully automated.

### 2) Configure kubectl

```bash
aws eks update-kubeconfig --region us-east-1 --name projeto-eks-personal
```

### 3) Validate AWS Load Balancer Controller (installed by Terraform)

```bash
kubectl -n kube-system get deploy aws-load-balancer-controller
kubectl -n kube-system get pods -l app.kubernetes.io/name=aws-load-balancer-controller -o wide
```

### 4) Deploy the portfolio app (single command)

From repo root:

```bash
kubectl apply -f k8s/apps/portfolio-nginx/
```

Validate:

```bash
kubectl -n portfolio get pods -o wide
kubectl -n portfolio get endpoints portfolio-nginx
kubectl -n portfolio get ingress
```

### 5) Pull the newest image after CI runs
The Deployment uses the `:latest` tag. After a new push, restart the pods:

```bash
kubectl -n portfolio rollout restart deploy/portfolio-nginx
```

### 5) DNS (manual)

After the Ingress is reconciled, it will show an ALB DNS name in the `ADDRESS` column:

```bash
kubectl -n portfolio get ingress
```

Create/update the Route53 record:
- Hosted Zone: `truecloud.com.br`
- Record: `www.truecloud.com.br`
- Target: the ALB DNS name from the Ingress

### 6) Smoke tests

```bash
curl -I http://www.truecloud.com.br
curl -I https://www.truecloud.com.br
```

Expected:
- HTTP returns **301/308** redirecting to HTTPS
- HTTPS returns **200**

## Destroy (clean teardown)

### 1) Remove the Kubernetes app first (recommended)

If you created an ALB via the Ingress, delete the app manifests **before** destroying the cluster,
so the AWS Load Balancer Controller can clean up the ALB/TargetGroups/SecurityGroups automatically.

From repo root:

```bash
kubectl delete -f k8s/apps/portfolio-nginx/
```

Wait until the Ingress is gone (and the ALB `ADDRESS` is empty):

```bash
kubectl -n portfolio get ingress
```

### 2) Terraform destroy

```bash
cd environments/personal
terraform init -upgrade
terraform destroy
```

Why this works:
- The Helm release (AWS Load Balancer Controller) is managed by Terraform, so it is destroyed as part of `terraform destroy`.

### 2) Optional post-checks

If you want to double-check nothing is left behind:
- In AWS console, search for leftover resources with prefixes like `k8s-` (ALB/TargetGroups/SecurityGroups).
- In Kubernetes (if the cluster still exists), verify `portfolio` namespace resources are gone.

