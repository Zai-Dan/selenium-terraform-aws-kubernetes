# The external dns sessions starts from here
resource "helm_release" "external_dns" {
  name          = "external-dns"
  namespace     = "${kubernetes_namespace.namespace.metadata.0.name}"
  chart         = "external-dns"
  repository    = "https://charts.bitnami.com/bitnami"
  version       = "6.7.2"
  values        = [
    "${trimspace(data.template_file.external_dns.rendered)}",
  ]
}


data "template_file" "external_dns" {
  template = <<EOF
provider: aws
aws:
  region: ${var.region}
serviceAccount:
  annotations:
    eks.amazonaws.com/role-arn: ${aws_iam_role.external_dns_access.arn}
EOF
}

resource "aws_iam_role" "external_dns_access" {
  name = "external-dns-access"

  assume_role_policy = jsonencode({
        "Version": "2012-10-17",
        "Statement": [
            {
                "Effect": "Allow",
                "Principal": {
                    "Federated": module.eks.oidc_provider_arn
                },
                "Action": "sts:AssumeRoleWithWebIdentity",
                "Condition": {
                    "StringEquals": {
                        "${replace(module.eks.cluster_oidc_issuer_url, "https://", "")}:sub": "system:serviceaccount:${kubernetes_namespace.namespace.metadata.0.name}:external-dns"
                    }
                }
            }
        ]
    })
}

resource "aws_iam_role_policy" "external_dns_access" {
  name = "external-dns-access"
  role = aws_iam_role.external_dns_access.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Effect" : "Allow",
        "Action" : "route53:ListHostedZones",
        "Resource" : "*"
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "route53:ChangeResourceRecordSets",
          "route53:ListResourceRecordSets"
        ],
        "Resource" : "arn:aws:route53:::hostedzone/*"
      }
    ]
  })
}


   

# The external dns sessions ends here 