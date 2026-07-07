# Week 2 - Task 1 | Custom VPC Architecture on AWS

## Overview

This project demonstrates the design and implementation of a custom Virtual Private Cloud (VPC) in Amazon Web Services (AWS). The infrastructure includes public and private subnets, custom route tables, an Internet Gateway, and an EC2 instance hosting a static website using the Apache HTTP Server.

The objective of this task was to understand the fundamentals of AWS networking by manually creating and configuring each networking component instead of relying on the default VPC.

---
## Architecture

```
                    Internet
                        │
                        ▼
              Internet Gateway (IGW)
                        │
          Public Route Table (0.0.0.0/0)
                        │
        ┌────────────────────────────────┐
        │        Custom VPC              │
        │         10.0.0.0/16            │
        │                                │
        │  Public Subnet                 │
        │    10.0.1.0/24                 │
        │          │                     │
        │          ▼                     │
        │     EC2 Instance               │
        │   Apache Web Server            │
        │                                │
        │────────────────────────────────│
        │ Private Subnet                 │
        │    10.0.2.0/24                 │
        │ (Reserved for future services) │
        └────────────────────────────────┘
```

A graphical version of the architecture is available in:

```
docs/vpc-architecture.png
```

---
## Network Design
_________________________________________________________
| Component 		| Configuration 		|
|-----------------------|-------------------------------|
| VPC 			| 10.0.0.0/16 			|
| Public Subnet 	| 10.0.1.0/24 			|
| Private Subnet 	| 10.0.2.0/24 			|
| Internet Gateway 	| Attached to VPC 		|
| Public Route Table 	| 0.0.0.0/0 → Internet Gatewa	|
| Private Route Table 	| Local route only 		|
| EC2 Instance 		| Amazon Linux 2023 (t2.micro) 	|
| Web Server 		| Apache HTTP Server 		|
---------------------------------------------------------
---
## Why a /16 VPC?

A **/16 CIDR block** provides a large private address space (65,536 IP addresses), allowing the VPC to be divided into multiple smaller subnets.
Each subnet uses a **/24 CIDR block**, providing 256 IP addresses while keeping the network organized and scalable for future workloads.
This design follows AWS networking best practices by separating infrastructure into isolated network segments.

---
## Traffic Flow

1. A client sends an HTTP request to the EC2 Public IP.
2. The request enters the VPC through the Internet Gateway.
3. The Public Route Table forwards traffic to the Public Subnet.
4. The EC2 instance receives the request.
5. Apache serves the website.
6. The response is sent back through the Internet Gateway.
7. The Private Subnet remains isolated because it has no Internet Gateway route.

Detailed explanation:

```
docs/traffic-flow.md
```

---
## Deployment Steps

- Created a custom VPC
- Created Public and Private Subnets
- Attached an Internet Gateway
- Configured Public and Private Route Tables
- Associated subnets with their respective Route Tables
- Launched an EC2 instance inside the Public Subnet
- Configured Security Groups
- Connected securely using SSH
- Installed Apache HTTP Server
- Hosted a custom HTML webpage
- Verified internet connectivity and successful deployment

---
## Verification

The following were successfully verified:
- SSH connectivity
- Internet connectivity using `ping`
- Apache service status
- Website accessibility through the EC2 Public IP

---
## Files

```
task1/
├── README.md
├── diagrams/
├── docs/
│   ├── traffic-flow.md
│   └── vpc-architecture.png
├── templates/
│   └── vpc-setup.yaml
└── screenshots/
```

---
## Learning Outcomes

Through this project, I learned:
- AWS VPC architecture
- CIDR block planning
- Public vs Private Subnets
- Route Tables and Internet Gateways
- Security Groups
- EC2 networking
- SSH authentication
- Apache Web Server deployment
- Website hosting on AWS

---
## Challenges Faced
- Initially attempted to SSH using an incorrect key path.
- Learned that Public IP addresses change after stopping and starting an EC2 instance.
- Resolved Apache deployment issues by verifying installation and service status.
- Understood the role of Route Tables in enabling or restricting internet access.
- Learned the importance of proper subnet association within a VPC.

---
## Author

**Timus**
