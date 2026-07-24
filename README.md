# ☁️  AWS Cloud Computing Internship

This repository documents my hands-on implementation of core AWS cloud services completed during a one-month Cloud Computing internship. Each week’s work includes architecture diagrams, implementation steps, troubleshooting notes, verification procedures, and supporting screenshots, making the repository both an internship submission and a reusable engineering reference.

The objective of this repository is to build a strong foundation in cloud computing through practical implementations using Amazon Web Services (AWS), while maintaining detailed documentation of concepts, configurations, challenges, and solutions.

---
## Repository Structure

AWS-internship/
│
├── README.md
├── CLEANUP-CHECKLIST.md
│
├── policies-created/
│   └── README.md
│
│
├── week1/
│   ├── task1/
│   ├── task2/
│   └── task3/
│
├── week2/
├── week3/
└── week4/

---

## 🚀 Internship Progress

| Week | Topics | Status |
|------|--------|--------|
| Week 1 | AWS Fundamentals, IAM, EC2 | ✅ Complete |
| Week 2 | Networking (VPC, Subnets, Route Tables) | ✅ Complete |
| Week 3 | CloudWatch, Auto Scaling, Load Balancer | ✅ Complete |
| Week 4 | CloudFormation, IAM Roles, S3 Integration | ✅ Complete |

---

## 🛠 AWS Services & Technologies

### Compute
- Amazon EC2
- Auto Scaling Groups
- Launch Templates

### Networking
- Amazon VPC
- Public & Private Subnets
- Route Tables
- Internet Gateway
- Security Groups
- Network ACLs
- Application Load Balancer
- Target Groups

### Security
- AWS IAM
- IAM Users
- IAM Groups
- IAM Roles
- IAM Policies
- AWS STS
- Multi-Factor Authentication (MFA)

### Storage
- Amazon S3

### Monitoring
- Amazon CloudWatch
- CloudWatch Alarms

### Developer Tools
- AWS CLI
- Git
- GitHub
- Linux (Amazon Linux 2023)
- Apache HTTP Server

---

## Documentation

Each task contains its own:
- README.md
- Screenshots
- Source Code
- Scripts (where applicable)
- Notes documenting key learnings and troubleshooting

---
## Learning Goals

Throughout this internship I aim to develop practical experience with:

- Cloud Computing Fundamentals
- AWS Core Services
- Infrastructure Deployment
- Linux System Administration
- Networking Basics
- Identity & Access Management (IAM)
- Automation using AWS CLI
- Cloud Security Best Practices

---

## 🌟 Internship Highlights

- Built secure AWS infrastructure using Amazon EC2 and VPC networking.
- Configured IAM users, groups, custom policies and IAM roles following least-privilege principles.
- Automated infrastructure deployment using AWS CloudFormation.
- Implemented Auto Scaling Groups and Application Load Balancers.
- Configured CloudWatch alarms for monitoring EC2 health.
- Integrated EC2 with Amazon S3 using IAM Roles and AWS STS.
- Documented architecture diagrams, troubleshooting notes and deployment procedures for every task.

---

## 📘 Key Lessons Learned

### Week 1 — AWS Foundations

- Root account should only be used for account-level administration.
- IAM users provide secure day-to-day access.
- SSH key pairs are safer than password authentication.
- AWS Budgets help avoid unexpected charges.

### Week 2 — Networking

- Public subnets require both an Internet Gateway and appropriate route table entries.
- Security Groups are stateful whereas Network ACLs are stateless.
- Route Tables determine how traffic leaves a subnet.

### Week 3 — High Availability

- Auto Scaling improves availability by replacing unhealthy instances.
- Load Balancers distribute traffic across multiple EC2 instances.
- CloudWatch provides monitoring and automated alerts.

### Week 4 — Security & Automation

- CloudFormation enables Infrastructure as Code.
- IAM Roles eliminate the need for long-term credentials on EC2 instances.
- Least-privilege IAM policies significantly improve cloud security.
- Systematic debugging is essential when diagnosing cloud networking issues.

---

## 🎯 Final Reflection

This internship provided practical experience with designing, deploying, securing and documenting cloud infrastructure using Amazon Web Services (AWS).

Beyond learning individual AWS services, the internship emphasized structured troubleshooting, infrastructure documentation, security best practices, automation and reproducible deployments. Every task was accompanied by diagrams, screenshots, debugging notes and implementation details, resulting in a repository that serves as both a submission and a personal engineering reference.

---
