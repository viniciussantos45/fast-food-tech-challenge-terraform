resource "aws_eks_cluster" "eks_cluster" {
  name     = "eks-cluster-1"
  role_arn = "arn:aws:iam::875456072639:role/LabRole"


  vpc_config {
    subnet_ids = var.subnet_ids
  }


  tags = {
    Name = "eks-cluster"
  }
}

resource "aws_eks_node_group" "eks_nodegroup" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = "eks-nodegroup"
  node_role_arn   = aws_eks_cluster.eks_cluster.role_arn
  subnet_ids      = var.subnet_ids


  scaling_config {
    desired_size = 2
    max_size     = 2
    min_size     = 1
  }

  instance_types = ["t3.medium"]

  tags = {
    Name = "eks-nodegroup"
  }
}

output "cluster_endpoint" {
  value = aws_eks_cluster.eks_cluster.endpoint
}
