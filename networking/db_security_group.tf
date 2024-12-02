resource "aws_security_group" "eks_node_sg" {
  name        = "eks_node_sg"
  description = "Security group for EKS worker nodes"
  vpc_id      = aws_vpc.main.id

  # Permitir comunicação entre os nós
  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    self      = true
  }

  # Permitir comunicação com o cluster EKS na porta 443
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Você pode restringir para o Security Group do Cluster EKS
  }

  # Regras de saída (egress) para permitir acesso à internet
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "eks-node-group-sg"
  }
}


output "db_sg_ids" {
  value = [aws_security_group.eks_node_sg.id]
}
