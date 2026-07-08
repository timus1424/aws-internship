# Week 2 - Task 2
# AWS Security Groups and Network ACLs

## Objective

The objective of this task was to understand how AWS secures network traffic using Security Groups and Network Access Control Lists (Network ACLs). This task focused on configuring firewall rules for EC2 instances and understanding how subnet-level traffic filtering works.

---
## Security Group Configuration
A custom Security Group named **week2-task2-sg** was created with the following inbound rules.
___________________________________________________________________________
| Protocol | Port | Source 		| Purpose 			  |
|----------|------|---------------------|---------------------------------|
| SSH 	   | 22   | My Public IP (/32)  | Secure remote administration 	  |
| HTTP     | 80   | 0.0.0.0/0 		| Public website access 	  |
| HTTPS    | 443  | 0.0.0.0/0 		| Secure encrypted website access |
---------------------------------------------------------------------------

Outbound traffic remains open to allow the EC2 instance to communicate with the internet.

---
## Why These Rules Were Chosen

### SSH
SSH is restricted to my current public IP address. This ensures only the administrator can remotely access the EC2 instance.
Allowing SSH from anywhere (0.0.0.0/0) would unnecessarily expose the server to automated attacks.

### HTTP
HTTP is open to everyone because the hosted website should be publicly accessible.

### HTTPS
HTTPS is also open to everyone to support secure encrypted web communication.

---
## Network ACL
The default Network ACL associated with the custom VPC was used.

### Inbound Rules
- Allow all traffic
- Default deny all

### Outbound Rules

- Allow all traffic
- Default deny all

The Network ACL is associated with both:
- week2-public-subnet
- week2-private-subnet

---
## Security Groups vs Network ACLs
_________________________________________________________________________________________
| Security Group 			| Network ACL 					|
|---------------------------------------|-----------------------------------------------|
| Applied to EC2 instances 		| Applied to subnets 				|
| Stateful 				| Stateless 					|
| Instance-level firewall 		| Subnet-level firewall 			|
| Return traffic automatically allowed 	| Return traffic must be explicitly allowed 	|
-----------------------------------------------------------------------------------------
---
## Files Included

- notes.md
- security-group.png
- network-acl-inbound.png
- network-acl-outbound.png
- network-acl-subnet-associations.png

---
## Learning Outcomes

- Understood TCP/IP ports and firewall concepts.
- Configured Security Groups using the principle of least privilege.
- Restricted SSH access to a trusted public IP.
- Allowed public HTTP/HTTPS access for web applications.
- Learned how Network ACLs provide subnet-level traffic filtering.
- Understood the differences between stateful Security Groups and stateless Network ACLs.

---
