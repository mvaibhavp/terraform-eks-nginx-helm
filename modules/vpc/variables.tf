variable "vpc_cidr" {
    description = "CIDR block for the VPC"
    type        = string
}

variable "public_subnet_cidrs" {
    description = "CIDR blocks for the public subnets"
    type        = list(string)
}

variable "aws_region" {
    description = "AWS region (used for AZ selection)"
    type        = string
}