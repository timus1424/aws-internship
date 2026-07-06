# Week 1 - Task 3

## Objective

Launch an Amazon EC2 instance, securely connect to it using SSH, install a web server, deploy a custom webpage, and understand the basics of cloud virtual machines.

---
## Progress

- [x] Launch EC2 Instance
- [x] Configure Security Group
- [x] Generate RSA Key Pair
- [x] Connect using SSH
- [x] Install Apache Web Server
- [x] Deploy HTML Page
- [x] Verify Public Access
- [x] Stop EC2 Instance
- [x] Documentation Complete

---
## Concepts Learned

Amazon Linux 2023 is AWS’s own Linux distribution. It is optimized for AWS infrastructure, receives long-term security updates, integrates well with AWS services, and is lightweight compared to desktop operating systems. Since it is maintained by AWS, it is the recommended choice for learning and deploying applications on EC2.

This task introduced the complete lifecycle of deploying a web server on Amazon EC2. I learned how to launch and secure an EC2 instance, authenticate using SSH key pairs, configure security groups, install and manage the Apache web server, deploy a custom HTML page, and troubleshoot connectivity issues such as changing public IP addresses and firewall rules.
---
##Practical Work Completed

---
## Challenges Faced
Launching the instance through the SSH Client.

### SSH Connectivity Troubleshooting
While configuring the EC2 instance, I encountered SSH connectivity issues, including `Permission denied (publickey)` and `Operation timed out` errors.
During troubleshooting, I learned that recreating an EC2 instance assigns a new public IP address and DNS name. I also verified the Security Group configuration to ensure SSH (port 22) was allowed only from my current public IP. After recreating the key pair, configuring the correct permissions (`chmod 400`), and using the updated public DNS, I successfully established the SSH connection.
- SSH uses an RSA key pair for authentication.
- Public IP addresses can change when a new EC2 instance is launched (or after a stop/start unless using an Elastic IP).
- Security Groups act as virtual firewalls and must allow SSH access from the correct client IP.

### Public IP Change
After recreating the EC2 instance and leaving the previous instance inactive, the Public IPv4 address changed.
Since SSH connections use the current public IP/DNS of the instance, the SSH command had to be updated with the new address.

**Resolution**
Retrieved the updated Public IPv4 and Public DNS from the EC2 console and connected using the new endpoint.
This helped me understand that Public IPs on EC2 are dynamic unless an Elastic IP is assigned.

---
##Notes
The internship guide referenced `t2.micro`; however, this AWS account provides `t3.micro` under the Free Tier. Therefore, `t3.micro` was used.

### Security Configuration
- Launched an EC2 instance in the Asia Pacific (Mumbai) Region.
- Configured inbound SSH (Port 22) access restricted to my public IP.
- Configured inbound HTTP (Port 80) access from anywhere (0.0.0.0/0) to allow public website access.

### SSH Connection
- Created a new RSA key pair for EC2 authentication.
- Stored the private key securely on the local machine.
- Restricted the private key permissions using `chmod 400`.
- Connected successfully to the EC2 instance using SSH.
- Verified the current working directory using `pwd` and confirmed the logged-in user using `whoami`.

---

