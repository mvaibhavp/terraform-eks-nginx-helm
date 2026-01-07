# 🚀 Production EKS + Ingress-Nginx (Terraform/Helm)

**Modular Terraform pipeline** deploying AWS EKS cluster + production Ingress-Nginx LoadBalancer.

[![terraform](https://img.shields.io/badge/terraform-v1.9.5-green)](https://www.terraform.io/)
[![eks](https://img.shields.io/badge/EKS-v1.31-blue)](https://aws.amazon.com/eks/)
[![ingress-nginx](https://img.shields.io/badge/Ingress-Nginx-v4.11.3-orange)](https://kubernetes.github.io/ingress-nginx)

## 🏗️ Architecture
                    INTERNET
                       │
                       │
        ┌──────────────▼──────────────┐
        │  Internet Gateway (IGW)     │
        │  eks-demo-igw               │
        └──────────────┬──────────────┘
                       │
                       │ (0.0.0.0/0 → IGW)
                       │
    ┌──────────────────┴──────────────────┐
    │      VPC: eks-demo-vpc              │
    │      CIDR: 10.0.0.0/16              │
    │                                     │
    │  ┌──────────────────────────────┐   │ 
    │  │  Public Route Table          │   │
    │  │  eks-demo-public-rt          │   │
    │  └──────────────────────────────┘   │
    │                                     │
    │  ┌──────────────┐  ┌──────────────┐ │
    │  │ Public Subnet│  │ Public Subnet│ │
    │  │ 10.0.1.0/24  │  │ 10.0.2.0/24  │ │
    │  │ us-east-1a   │  │ us-east-1b   │ │
    │  │              │  │              │ │
    │  │ [EKS Nodes]  │  │ [EKS Nodes]  │ │
    │  └──────────────┘  └──────────────┘ │
    └─────────────────────────────────────┘
            │                    │
            ▼                    ▼
        ┌──────────────┐ ┌──────────────┐
        │ EKS Cluster  │ │ Ingress-Nginx │
        │ eks-demo-... │ │ LoadBalancer  │
        │ 2x t3.micro  │ │ ELB: a9312fcb│
        └──────────────┘ └──────────────┘
            │                    │
            └──────────┬─────────┘
                       │
                    curl EXTERNAL-IP → 404 ✓

## 🚀 Quick Demo (2 minutes)
```bash
# Clone + AWS credentials
git clone https://github.com/mvaibhavp/terraform-eks-nginx-helm
cd terraform-eks-nginx-helm

# Initialize + deploy (Free Tier t3.micro)
terraform init
terraform apply

# Get LoadBalancer → curl demo
kubectl get svc -n ingress-nginx
curl http://EXTERNAL-IP  # → 404 (controller healthy!)

📁 Structure
├── modules/
│   ├── vpc/           # VPC + public subnets 
│   ├── eks/           # EKS cluster + node groups (eks-demo-cluster)
│   └── helm-nginx/    # Ingress-Nginx LoadBalancer
├── provider.tf        # AWS EKS provider 
├── main.tf            # Root module calls
└── outputs.tf         # Cluster endpoint + VPC details

💰 Free Tier ($0)
- ✅ t3.micro nodes (Free Tier eligible)
- ✅ Daily destroy: `terraform destroy -target=module.eks -target=module.helm_nginx`
- ✅ VPC preserved (always $0)

🧪 Verify Deployment
kubectl get nodes                    # 2x t3.micro Ready
kubectl get pods -n ingress-nginx    # Controller Running
kubectl get svc -n ingress-nginx     # LoadBalancer EXTERNAL-IP
curl http://EXTERNAL-IP              # 404 = Production ready!

🎯 Use Cases
API Gateway: Route /api → backend services
Microservices: /web, /admin, /app1, /app2
Production EKS foundation

🔄 Daily Workflow
terraform apply                       # 2-3 min → demo ready
# DEMO
terraform destroy -target=module.eks -target=module.helm_nginx  # $0
