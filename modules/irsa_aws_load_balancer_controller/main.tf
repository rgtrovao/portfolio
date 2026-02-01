data "tls_certificate" "issuer" {
  url = var.cluster_oidc_issuer_url
}

resource "aws_iam_openid_connect_provider" "this" {
  url             = var.cluster_oidc_issuer_url
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.issuer.certificates[0].sha1_fingerprint]

  tags = merge(local.common_tags, { Name = "${local.name_prefix}-eks-oidc" })
}

resource "aws_iam_policy" "controller" {
  name   = "${local.name_prefix}-aws-load-balancer-controller"
  policy = var.policy_json

  tags = merge(local.common_tags, { Name = "${local.name_prefix}-aws-load-balancer-controller" })
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"
    actions = [
      "sts:AssumeRoleWithWebIdentity",
    ]

    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.this.arn]
    }

    condition {
      test     = "StringEquals"
      variable = "${local.issuer_hostpath}:aud"
      values   = ["sts.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "${local.issuer_hostpath}:sub"
      values   = ["system:serviceaccount:${var.namespace}:${var.serviceaccount_name}"]
    }
  }
}

resource "aws_iam_role" "this" {
  name               = local.role_name
  assume_role_policy = data.aws_iam_policy_document.assume_role.json

  tags = merge(local.common_tags, { Name = local.role_name })
}

resource "aws_iam_role_policy_attachment" "controller" {
  role       = aws_iam_role.this.name
  policy_arn = aws_iam_policy.controller.arn
}

