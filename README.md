# TechNova Solutions
AWS Development Environment Capstone Project
## Introduction
This project involved designing, provisioning, and deploying a fully automated development environment for TechNova Solutions using AWS cloud services. The objective was to build infrastructure using Terraform, configure and deploy the application using Ansible, and ensure the environment can be destroyed and rebuilt reliably.
## Local Development Environment
All infrastructure provisioning and configuration tasks were executed from Ubuntu WSL (Windows Subsystem for Linux). The following tools were installed and configured:
- Terraform
- Ansible
- AWS CLI
- SSH Key Pair for EC2 access
## Infrastructure Provisioning with Terraform
The infrastructure was  provisioned entirely using Terraform without creating any resources manually via the AWS Console.
Resources Created:
- Custom VPC (10.0.0.0/16)
- Public Subnet (10.0.1.0/24) for EC2
- Private Subnet (10.0.2.0/24) for RDS
- Internet Gateway
- Route Tables and Associations
- EC2 Instance (Free Tier Eligible)
- RDS Database (MySQL/PostgreSQL - Free Tier)
- Amazon S3 Bucket (Private)
- Security Groups following least privilege principle
Terraform variables were used for CIDR blocks, instance type, database credentials, and other configurable values. Outputs such as EC2 public IP and RDS endpoint were exported for use in Ansible.

<img width="1536" height="1024" alt="aws pics" src="https://github.com/user-attachments/assets/c52d9f07-4bf8-4d73-8d50-2ca48a947e0e" />

## Networking and Security Design
- EC2 deployed in Public Subnet with HTTP (Port 80) open to the internet.
- SSH (Port 22) restricted to administrator IP only.
- RDS deployed in Private Subnet with no public access.
- Database port accessible only from EC2 security group.
- S3 bucket configured as private by default.
- IAM Role attached to EC2 for secure S3 access.
## Application Deployment with Ansible
After infrastructure provisioning, Ansible was used to configure the EC2 server and deploy the web application automatically.
Steps Automated via Ansible:
- System package updates
- Installation of Python and required dependencies
- Installation of FastAPI framework
- Deployment of application source code
- Configuration of database connection
- Creation of systemd service for application
- Application startup and enablement
The application was built using Python FastAPI framework and configured to connect securely to the RDS database and S3 bucket.
## Live Application
The deployed application is accessible at the following public IP address:
http://100.53.45.56
## Idempotent Deployment
Both Terraform and Ansible configurations are idempotent. The environment can be destroyed and recreated using:
terraform destroy
terraform apply
ansible-playbook -i inventory.ini playbook.yml
## Production Cost Estimate
For a production environment serving approximately 5,000 daily active users, the architecture would include:
- Auto Scaling Group (Minimum 2 EC2 instances)
- Application Load Balancer
- RDS Multi-AZ Deployment
- NAT Gateway
- Daily Automated Backups
Estimated Monthly Cost: Approximately $275.
## Key Learnings
- Importance of Infrastructure as Code
- Security best practices in VPC design
- Difference between development and production architecture
- Automation and reproducibility in cloud environments
