variable "aws_region" {
  description = "The AWS region to deploy the resources in"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "The CIDR blocks for the public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

# EKS cluster variables
variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "eks-demo-cluster"
}

# EKS version
variable "eks_version" {
  description = "Kubernetes version for EKS"
  type        = string
  default     = "1.30"
}

# EKS node group variables
variable "node_group_name" {
  description = "Name of the EKS node group"
  type        = string
  default     = "eks-demo-workers"
}

# EKS node instance type
variable "node_instance_type" {
  description = "EC2 instance type for worker nodes"
  type        = string
  default     = "t3.micro"
}

# EKS desired node count
variable "desired_node_count" {
  description = "Desired number of worker nodes"
  type        = number
  default     = 2
}
