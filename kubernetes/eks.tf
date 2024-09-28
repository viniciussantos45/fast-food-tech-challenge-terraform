resource "aws_eks_cluster" "main" {
  name     = "main"
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids = var.subnets
  }
}
