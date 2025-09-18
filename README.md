# Project Bedrock - InnovateMart

This repository contains the Infrastructure-as-Code and Kubernetes manifests to deploy the retail-store-sample-app to Amazon EKS.

Structure:
- infra/: Terraform code (VPC, EKS, IAM, etc.)
- k8s/: Kubernetes manifests and Helm values
- .github/workflows/: CI/CD workflows (Terraform plan/apply, build & deploy)

Follow the README sections to provision infra and deploy the app.
