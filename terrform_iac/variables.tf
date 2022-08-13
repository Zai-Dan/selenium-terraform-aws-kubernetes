#
# Variables Configuration
#

variable "cluster-name" {
  default = "terraform-eks-demo"
  type    = string
}

variable "namespace" {
  default = "selenium-ingress"
  type    = string
}

variable "kubernetes_namespace" {
  default = "selenium-ingress"
  type    = string
}
