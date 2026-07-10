# Week 3 - Task 1 Notes

## Objective

Deploy a highly available web application using:

- Launch Template
- Auto Scaling Group
- Application Load Balancer
- Target Group
- Multiple Public Subnets
- Health Checks

---

## Resources Created

- Launch Template
- Target Group
- Application Load Balancer
- Auto Scaling Group
- Additional Public Subnet
- Security Group

---

## Learning

- Launch Templates standardize EC2 configuration.
- Auto Scaling Groups automatically launch or terminate EC2 instances.
- Application Load Balancer distributes traffic across multiple EC2 instances.
- Target Groups define where ALB forwards requests.
- Health checks remove unhealthy instances automatically.
- Using multiple Availability Zones improves fault tolerance.

---

## Challenges Faced

- Understanding the relationship between Target Groups and ALB.
- Creating an additional subnet in another Availability Zone.
- Configuring ALB with multiple public subnets.
- Connecting the Auto Scaling Group with the Target Group.
- Understanding scaling policies and health checks.

---

## Outcome

Successfully created an Auto Scaling infrastructure capable of serving traffic through an Application Load Balancer while maintaining high availability.
