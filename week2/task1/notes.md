# Week 2 Notes

## CIDR

10.0.0.0/16

A /16 means the first 16 bits identify the network.

The remaining bits are available for hosts and subnetting.

---
## Why /16 for the VPC and /24 for Subnets?

The VPC uses a larger CIDR block (`10.0.0.0/16`) to reserve a broad private IP address space.

Individual subnets use smaller CIDR blocks (`/24`) to divide the VPC into manageable network segments while leaving room for future expansion.

---
## Public vs Private Subnet

Public:
- Has a route to the Internet Gateway.

Private:
- No direct Internet route.

---
Public subnet:
Internet
    │
   IGW
    │
Public Route Table
    │
Public Subnet

Private subnet:
Private Route Table
        │
Private Subnet

---
Why do we explicitly enable “Auto-assign Public IP” this time instead of leaving it to chance?
We enable Auto-assign Public IP because the EC2 instance needs a publicly reachable IP address to communicate with the internet. Since we’ll be connecting over SSH from our laptop and verifying internet connectivity, the instance must receive a public IP. Without one, even if it’s in a public subnet with an Internet Gateway and correct route table, it wouldn’t be directly reachable from the internet.

---

Questions

1.Why is the route table separate from the subnet?

2.Why is the VPC /16 but the subnets are /24?
-> A VPC is typically assigned a larger CIDR block, such as 10.0.0.0/16, to provide a broad private IP address space that can accommodate multiple subnets as the infrastructure grows. Individual subnets use smaller CIDR blocks, such as /24, to logically segment the network into public, private, database, or application tiers while leaving sufficient room for future expansion within the same VPC.

