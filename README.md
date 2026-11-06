# AWS Serverless CI/CD Pipeline 🚀

An automated, Infrastructure-as-Code (IaC) deployment pipeline for a Python FastAPI backend. This project provisions serverless AWS architecture and completely automates the container build and deployment process using GitHub Actions.

## 🏗️ Architecture & Technologies

* **Compute:** AWS Fargate (Serverless ECS)
* **Container Registry:** Amazon ECR
* **Infrastructure as Code:** Terraform (with S3 State Backend)
* **CI/CD:** GitHub Actions
* **Security:** OpenID Connect (OIDC) for keyless AWS authentication
* **Backend:** Python FastAPI & Docker

## ⚙️ How It Works

1. **Trigger:** A developer pushes code to the `main` branch.
2. **Authenticate:** GitHub Actions securely authenticates with AWS via an OIDC federated identity token (zero static credentials).
3. **Provision:** Terraform validates and applies the infrastructure configuration, building the VPC, security groups, and ECS cluster.
4. **Build & Push:** The pipeline builds a new Docker container from the FastAPI application and pushes it to Amazon ECR.
5. **Deploy:** The ECS Fargate service automatically pulls the latest `latest` image and rolls out the updated container to the live internet.

## 🛡️ Security Best Practices Implemented

* **Keyless Authentication:** Eliminated long-lived IAM Access Keys by utilizing OIDC trust policies.
* **Least Privilege:** IAM roles strictly scoped to specific GitHub repositories and AWS services.
* **Immutable Infrastructure:** All AWS resources are strictly version-controlled through Terraform state.
