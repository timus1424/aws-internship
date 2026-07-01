# Week 1 - Task 1

## Objective

Understand the fundamentals of cloud computing and perform the initial AWS account setup following security best practices.

---
## Tasks Completed
- Researched cloud computing fundamentals
- Learned deployment and service models
- Created AWS Free Tier account
- Enabled Root MFA
- Created IAM Administrator user
- Configured AWS CLI
- Verified CLI authentication
- Created Zero Spend Budget

---
## Concepts Learned
- Cloud Computing
- Public, Private and Hybrid Cloud
- IaaS, PaaS and SaaS
- AWS Regions
- Availability Zones
- IAM
- Root User vs IAM User
- AWS CLI

---
## AWS Services Used
- IAM
- AWS CLI
- AWS Budgets
- Billing & Cost Management

---
## Challenges Faced

### Organizing the Project Repository
Initially, I focused only on completing the technical tasks. As the project progressed, I realized that organizing documentation, screenshots, and reports into a consistent directory structure was equally important for maintainability.

**Resolution**
I reorganized the repository into weekly and task-based folders and created individual README files for each task to improve clarity and future scalability.
---
### Learning AWS CLI
Initially unfamiliar with configuring AWS CLI and generating access keys.

**Resolution**
Configured the AWS CLI using an IAM user and verified authentication using:

```bash
aws sts get-caller-identity
```

---
## Folder Structure

```text
docs/
screenshots/
README.md
```

---
## Learning Outcome
Through this task, I gained a practical understanding of cloud computing fundamentals and AWS account security. I learned the importance of following security best practices such as enabling MFA, using IAM users instead of the Root account for daily administration, monitoring account costs with AWS Budgets, and authenticating the AWS CLI using programmatic credentials.s, and command-line interaction through the AWS CLI.

---
## Keytakeaways
- gh CLI
- tree
