module "vpc" {
  source = "./modules/vpc"

  vpc_cidr            = var.vpc_cidr
  public_subnet_cidrs = var.public_subnet_cidrs
  aws_region          = var.aws_region
}

module "eks" {
  source = "./modules/eks"

  vpc_id             = module.vpc.vpc_id
  public_subnet_ids  = module.vpc.public_subnet_ids
  cluster_name       = var.cluster_name
  eks_version        = var.eks_version
  node_group_name    = var.node_group_name
  node_instance_type = var.node_instance_type
  desired_node_count = var.desired_node_count

  depends_on = [module.vpc]
}