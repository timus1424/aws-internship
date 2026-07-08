# Week 2 - Task 3

## Deploying a Web Application within a VPC

## Objective

Deploy a simple static web application on an Amazon EC2 instance inside the custom VPC created in Week 2.

---

## Services Used

- Amazon EC2
- Amazon VPC
- Security Groups
- Internet Gateway
- Route Tables
- Apache HTTP Server (httpd)

---

## Deployment Steps

1. Created a public EC2 instance.
2. Connected using SSH.
3. Installed Apache HTTP Server.
4. Started and enabled the Apache service.
5. Created a custom HTML page.
6. Copied the HTML page to `/var/www/html/index.html`.
7. Verified the deployment using:
   - Browser
   - curl localhost

---

## Architecture Design

                    Internet
                        │
                        ▼
              Internet Gateway (IGW)
                        │
                        ▼
                 Public Route Table
                        │
                        ▼
                 Public Subnet
                (10.0.1.0/24)
                        │
                        ▼
               EC2 Instance (t3.micro)
              Amazon Linux 2023
                        │
               Apache HTTP Server
                        │
                        ▼
               Static Web Application

──────────────────────────────────────────────

Private Subnet (10.0.2.0/24)
(No Internet Access)

---
## Commands Used

```bash
sudo dnf install httpd -y
sudo systemctl start httpd
sudo systemctl enable httpd
sudo cp ~/index.html /var/www/html/index.html
curl http://localhost

---

## Challenges Faced

During this deployment, several practical networking issues were encountered and resolved.

* SSH connectivity initially failed due to subnet and public IP configuration.
* EC2 Instance Connect could not establish sessions until the networking configuration was corrected.
* The instance received a different public IPv4 address after recreation, requiring the SSH Security Group rule to be updated.
* Understanding the interaction between Security Groups, Network ACLs, Route Tables, Internet Gateway, and Subnets required careful troubleshooting.
* Apache appeared slow during initial setup because the EC2 instance was installing packages and starting services on limited Free Tier resources.

Resolving these issues significantly improved my understanding of AWS networking and EC2 deployment.

---

## Reflection

This task was my first complete end-to-end deployment of a web application on AWS. While configuring the networking components and troubleshooting SSH connectivity was initially challenging, it helped me understand how VPCs, Security Groups, Route Tables, Internet Gateways, and EC2 instances work together. Completing the deployment successfully gave me a much clearer understanding of AWS infrastructure and reinforced the importance of systematic debugging.

---
