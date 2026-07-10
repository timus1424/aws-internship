# Week 3 - Task 1

High Availability with Auto Scaling and Application Load Balancer

## Objective

Create a fault-tolerant infrastructure capable of automatically scaling EC2 instances while distributing incoming HTTP traffic using an Application Load Balancer.

---
## AWS Services Used

- EC2
- Launch Templates
- Application Load Balancer
- Target Groups
- Auto Scaling
- VPC
- Public Subnets
- Security Groups

---
## Architecture

                 Internet
                     │
                     ▼
         Application Load Balancer
                     │
             Target Group (HTTP)
                     │
        ┌────────────┴────────────┐
        ▼                        ▼
   EC2 Instance             EC2 Instance
        │                        │
        └────────────┬────────────┘
                     │
            Auto Scaling Group
                     │
             Launch Template
                     │
              User Data Script

---
## Progress

- [x] Launch Template
- [x] Target Group
- [x] Second Public Subnet
- [x] Application Load Balancer
- [x] Auto Scaling Group
- [x] Scaling Policy
- [x] Testing

---
## Screenshots

- 01-launch-template-created.png
- 02-target-group-created.png
- 03-week3-public-subnet.png
- 04-public-subnets.png
- 05-alb-review-page.png			
- 06-week3-alb-created.png		
- 07-alb+launchtemplate.png
- 08-load_balancer+target_group.png
- 09-elb-health-checks.png
- 10-scaling-policy.png
- 11-review-alb.jpeg
- 12-auto-scaling-overview.png
- 13-verified-auo-scaling.png
- 14-target-group-verified.png
- 15-load-balacer-verified.png

---
## Learning

- Difference between Launch Template and EC2
- Difference between ALB and Target Group
- High Availability
- Scaling
- Load Distribution
- Health Checks

---
## Challenges

- Understanding the relationship between Launch Templates, Target Groups, Application Load Balancers, and Auto Scaling Groups before configuring them together.
- Creating an additional public subnet in a different Availability Zone to satisfy the Application Load Balancer requirements.
- Differentiating the responsibilities of the Load Balancer and Target Group during request routing.
- Configuring Auto Scaling Groups with appropriate minimum, desired, and maximum capacities.
- Understanding how User Data automates EC2 instance configuration during launch.
- Verifying target health and ensuring successful communication between the Auto Scaling Group, Target Group, and Load Balancer.
- Managing multiple AWS resources simultaneously while maintaining a consistent and organized infrastructure.

---
## Learning Outcomes

- Learned how Launch Templates standardize EC2 instance configuration for automated deployments.
- Understood how User Data scripts automate software installation and application deployment during instance initialization.
- Gained practical experience configuring an Application Load Balancer to distribute incoming traffic across multiple EC2 instances.
- Learned how Target Groups register, monitor, and route requests only to healthy EC2 instances.
- Configured an Auto Scaling Group to automatically maintain the desired number of EC2 instances.
- Understood the importance of deploying resources across multiple Availability Zones to improve application availability and fault tolerance.
- Strengthened understanding of how AWS networking components and compute services work together to build scalable and resilient cloud infrastructure.
- Improved troubleshooting and documentation skills by systematically configuring, validating, and recording each stage of the deployment process.

---
