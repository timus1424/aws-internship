# AWS Cleanup Checklist

Infrastructure cleanup is an important part of cloud engineering.

Unlike local development, many AWS resources continue running after a task is completed and may incur charges. Cleaning up unused resources helps control costs and keeps the AWS environment organized.

---

## Cleanup Completed Before Starting Week 4

### EC2:
- [x] Terminated `week2-public-ec2`
- [x] Terminated Auto Scaling instances created during Week 3

### Auto Scaling:
- [x] Deleted `week3-asg`

### Load Balancing:
- [x] Deleted `week3-alb`
- [x] Deleted `week3-target-group`

### CloudFormation:
- [x] Deleted the Week 3 CloudFormation stack after completing documentation and collecting screenshots.

### Verification:
- [x] Confirmed no unnecessary EC2 instances remained running.
- [x] Confirmed no unnecessary Load Balancers remained active.
- [x] Confirmed Auto Scaling Groups were removed.
- [x] Confirmed Target Groups were removed.
- [x] Retained only non-billable configuration resources (such as Launch Templates) for future tasks.

---

## AWS Resources That Commonly Incur Charges

| Resource | Notes |
|----------|-------|
| EC2 Instances | Running instances incur compute charges. |
| EBS Volumes | Persist until deleted. |
| Application Load Balancers | Charged while active, regardless of traffic. |
| NAT Gateways | Charged hourly and for processed data. |
| Elastic IPs | May incur charges when allocated but unused. |

---

## Personal Cleanup Workflow

Before ending each internship task:

- Check EC2 Instances
- Check Auto Scaling Groups
- Check Load Balancers
- Check Target Groups
- Check CloudFormation Stacks
- Check EBS Volumes
- Check Elastic IPs
- Review AWS Billing Dashboard

This checklist will continue to be updated throughout the internship.

---

## Lesson Learned

One of the biggest differences between cloud infrastructure and local development is that cloud resources continue running until they are explicitly stopped or deleted. Performing cleanup after every task is essential to prevent unnecessary costs and maintain a clean AWS environment.

---
