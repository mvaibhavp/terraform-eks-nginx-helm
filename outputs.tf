output "vpc_id" {
  description = "ID of the VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "IDs of public subnets"
  value       = module.vpc.public_subnet_ids
}

output "eks_cluster_name" {
  value = module.eks.cluster_name
}

output "eks_cluster_endpoint" {
  description = "kubernetes API endpoint"
  value = module.eks.cluster_endpoint
}

output "eks_cluster_ca_certificate" {
  description = "Cluster CA certificate"
  value = module.eks.cluster_ca_certificate
  sensitive = true
}

output "eks_cluster_security_group_id" {
  value = module.eks.cluster_security_group_id
}