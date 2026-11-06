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


## 🚀 How to Adapt This Pipeline for Your Own Project

You can fork this repository to use as a boilerplate for deploying your own containerized backend to AWS Fargate. 

### 1. Prerequisites
* An AWS Account.
* A GitHub repository.
* Your own application code and a valid `Dockerfile`.

### 2. Configure Keyless AWS Authentication (OIDC)
For security, this pipeline does not use hardcoded AWS Access Keys. You must configure an OpenID Connect (OIDC) Identity Provider in your AWS account to trust your GitHub repository.
1. Go to AWS IAM > Identity Providers > Add Provider (Provider URL: `https://token.actions.githubusercontent.com`, Audience: `sts.amazonaws.com`).
2. Create an IAM Role for GitHub Actions with permissions for ECS, ECR, and VPC provisioning.
3. Edit the Trust Policy to strictly allow your specific GitHub repository name.

### 3. Update Pipeline Variables
Open `.github/workflows/deploy.yml` and replace the target variables with your own AWS details:
* Replace the `role-to-assume` ARN with your new IAM Role ARN (including your 12-digit AWS Account ID).
* Update the `aws-region` if you are deploying outside of `ap-southeast-1`.

### 4. Swap the Application Code
This template includes a dummy Python FastAPI application. 
1. Delete the contents of the `app/` directory.
2. Paste in your own backend code (Node.js, Go, Python, etc.).
3. Update the root `Dockerfile` to build your specific language and framework.

### 5. Deploy
Commit your changes and run `git push origin main`. GitHub Actions will automatically log into your AWS account, provision the Terraform infrastructure, and deploy your new container to the public internet.
