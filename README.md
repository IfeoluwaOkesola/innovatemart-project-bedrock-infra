# Project Bedrock — InnovateMart Retail Store Deployment
2nd Assignment for 3rd Semester cloud Engineering at Alt School
## 1. Architecture Overview
This project provisions the **Retail Store Sample App** on **Amazon Elastic Kubernetes Service (EKS)** using Terraform.

### Components
- **Networking**
  - VPC with public & private subnets across multiple AZs.
  - Public subnets → AWS Load Balancer.
  - Private subnets → EKS worker nodes.

- **Compute**
  - EKS cluster: `bedrock-eks`
  - Managed node group (`t3.large`) running in private subnets.

- **Microservices**
  - `carts` (with DynamoDB Local)
  - `catalog` (with MySQL in-cluster)
  - `checkout` (with Redis in-cluster)
  - `orders` (with PostgreSQL + RabbitMQ in-cluster)
  - `ui` (frontend exposed via AWS Load Balancer)

- **IAM & Security**
  - IAM roles for cluster and node groups.
  - **Read-only IAM user (`dev-readonly`)** created for developer access.
  - RBAC integrated with IAM for secure access.

- **CI/CD**
  - GitHub Actions pipeline:
    - Pull Requests → `terraform plan`
    - Merges to `main` → `terraform apply`

---

## 2. Application Access
The **UI service** is exposed publicly via AWS Load Balancer: http://aabeab45eec0948b1a1f2a48ac4c6633-1151972160.eu-west-1.elb.amazonaws.com

## 3. Developer Access (Read-Only)

A read-only IAM user named **`dev-readonly`** has been created to allow developers to inspect the cluster without modifying resources.

### Credentials
- **IAM Username:** `dev-readonly`
- **IAM ARN:**  
  `arn:aws:iam::916863632865:user/dev-readonly`

> ⚠️ Access Key / Secret are shared securely outside of GitHub in goggle docs submited.

### Setup Instructions

1. Configure AWS CLI profile:
   ```bash
   aws configure --profile dev-readonly
   # enter access key + secret when prompted
```
2. Update kubeconfig
```bash
aws eks update-kubeconfig \
  --name bedrock-eks \
  --region eu-west-1 \
  --profile dev-readonly
```
3. Verify permissions
```bash
kubectl get pods --all-namespaces     # ✅ allowed
kubectl logs <pod-name>               # ✅ allowed
kubectl delete pod <pod-name>         # ❌ forbidden
``` 
