# Week 3 – Task 2
# Centralized Logging with Amazon CloudWatch

## Objective

Configure Amazon CloudWatch Agent on an EC2 instance to collect infrastructure metrics and system logs, laying the foundation for centralized monitoring and observability.

---

## Technologies

- Amazon EC2
- Amazon CloudWatch
- IAM Roles & Instance Profiles
- Auto Scaling Group
- Launch Templates
- Amazon Linux 2023
- Systems Manager (SSM)

---

## Repository Structure

```
week3/
└── task2/
    ├── README.md
    ├── notes.md
    ├── config/
    │   └── cloudwatch-agent-config.json
    └── screenshots/
```

---

## Implementation Summary

Completed:

- Installed Amazon CloudWatch Agent
- Created dedicated IAM Role
- Attached:
  - CloudWatchAgentServerPolicy
  - AmazonSSMManagedInstanceCore
- Created Instance Profile
- Updated Launch Template
- Updated Auto Scaling Group
- Replaced EC2 instance
- Generated CloudWatch Agent configuration
- Started and verified CloudWatch Agent
- Exported CloudWatch configuration JSON

---

## Engineering Challenges

This task became an excellent exercise in cloud infrastructure debugging rather than a straightforward configuration exercise.

### Challenge 1 — Missing IAM Role

The initial EC2 instance launched without an IAM Instance Profile because the original Launch Template did not reference one.

Solution:

- Created an Instance Profile
- Updated the Launch Template
- Updated the Auto Scaling Group
- Replaced the existing EC2 instance

---

### Challenge 2 — Auto Scaling Behavior

Updating the Launch Template alone did not modify the running EC2 instance.

Lesson:

Existing instances continue using their original configuration until replaced by the Auto Scaling Group.

---

### Challenge 3 — CloudWatch Logs Never Appeared

Although:

- CloudWatch Agent was installed
- Agent was running
- IAM Role was correctly attached
- Configuration loaded successfully

No Log Group appeared inside CloudWatch.

After investigation, the root cause was identified:

Amazon Linux 2023 primarily uses **systemd-journald**, while the CloudWatch Agent wizard defaulted to monitoring:

```
/var/log/messages
```

This mismatch prevented log collection despite an otherwise healthy configuration.

---

## Key Learning Outcomes

- IAM Roles are attached through Instance Profiles.
- Launch Templates are immutable; changes require new versions.
- Auto Scaling Groups only apply Launch Template changes to newly launched instances.
- Infrastructure debugging should be systematic rather than based on assumptions.
- CloudWatch Agent configuration should always be validated against the operating system being monitored.

---

## Current Status

- IAM configuration complete
- Auto Scaling configuration complete
- CloudWatch Agent operational
- Configuration exported
- Log collection investigation documented

---

## Files Included

- CloudWatch Agent configuration
- Engineering notes
- Screenshots
- Deployment documentation

---
