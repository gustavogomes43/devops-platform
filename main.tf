provider "aws" {
  region = "us-east-1"
}

# 1. Rede (VPC) - Cria a infraestrutura de rede necessária para o Cluster
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = "devops-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b"]
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.3.0/24", "10.0.4.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true 
}

# 2. Cluster EKS - Configuração do Kubernetes
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "devops-cluster-new"
  cluster_version = "1.28" # Versão estável e suportada pela AWS

  vpc_id                         = module.vpc.vpc_id
  subnet_ids                     = module.vpc.private_subnets
  cluster_endpoint_public_access = true

  enable_cluster_creator_admin_permissions = true

  eks_managed_node_groups = {
    default = {
      # t3.small garante IPs e RAM suficientes para o ArgoCD e sua App
      instance_types = ["t3.small"]
      
      # Amazon Linux 2 é a imagem mais estável para esse setup
      ami_type = "AL2_x86_64"

      # Definimos 2 nós como desejado para dividir a carga do ArgoCD
      min_size     = 2
      max_size     = 3
      desired_size = 2
    }
  }
}
