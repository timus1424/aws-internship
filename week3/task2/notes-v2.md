# CloudWatch — Week 3 Task 2 Notes

---

# 1. What is CloudWatch?

CloudWatch is AWS's monitoring and observability service.

Think of it as the dashboard of your infrastructure.

It collects:

- Metrics
- Logs
- Events
- Alarms

from AWS resources so they can be monitored from one place.

---

# 2. Metrics vs Logs vs Dashboards vs Alarms

## Metrics

Numerical measurements collected over time.

Example:

- CPU Utilization
- Network In
- Disk Read Ops

---

## Logs

Detailed records describing events.

Example:

```
Apache started
User logged in
Database connection failed
```

---

## Dashboards

Visual collection of CloudWatch metrics.

Useful for monitoring multiple resources from one screen.

---

## Alarms

Rules triggered when metrics cross thresholds.

Example:

> CPU > 90% for 5 minutes

---

# 3. CloudWatch Agent

CloudWatch cannot see inside an EC2 operating system by default.

The CloudWatch Agent extends monitoring by collecting:

- Memory
- Disk usage
- Disk I/O
- Swap
- Application logs
- Custom metrics

---

# 4. Log Groups vs Log Streams

## Log Group

Container that stores related logs.

Example:

```
week3-system-logs
```

---

## Log Stream

Logs from a single instance.

Example:

```
i-0f896ced...
```

---

# 5. Centralized Logging

Instead of SSH-ing into every EC2 instance:

```
EC2
    │
CloudWatch Agent
    │
CloudWatch Logs
    │
Dashboard
    │
Alarms
```

Everything becomes searchable from one location.

---

# 6. CloudWatch Agent Configuration Decisions

## Run As User

Choice:

```
cwagent
```

Reason:

Least privilege.

---

## StatsD

Enabled.

Reason:

Allows future custom metrics.

---

## CollectD

Disabled.

Reason:

Not installed.

---

## Host Metrics

Enabled.

Collected:

- CPU
- Memory
- Disk
- Swap
- Disk I/O

---

## EC2 Dimensions

Enabled.

Automatically attaches:

- Instance ID
- Instance Type
- Image ID
- Auto Scaling Group

---

## Collection Interval

60 seconds.

Reason:

Good balance between visibility and cost.

---

## Log File

Configured:

```
/var/log/messages
```

---

## Log Group

```
week3-system-logs
```

---

## Retention

30 Days

---

## X-Ray

Disabled.

Reason:

Only infrastructure monitoring required.

---

# 7. Commands Used

Install Agent

```bash
sudo dnf install amazon-cloudwatch-agent
```

Run Wizard

```bash
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-config-wizard
```

Start Agent

```bash
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl \
-a fetch-config \
-m ec2 \
-c file:/opt/aws/amazon-cloudwatch-agent/bin/config.json \
-s
```

Status

```bash
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl \
-m ec2 \
-a status
```

Logs

```bash
sudo tail -100 \
/opt/aws/amazon-cloudwatch-agent/logs/amazon-cloudwatch-agent.log
```

---

# 8. Troubleshooting Journey

## Initial Setup

- Installed CloudWatch Agent
- Created IAM Role
- Attached CloudWatchAgentServerPolicy
- Added AmazonSSMManagedInstanceCore
- Created Instance Profile
- Updated Launch Template
- Updated Auto Scaling Group
- Replaced EC2 instance

---

## Investigation

Verified:

- Agent installed
- Agent running
- Agent configured
- IAM Role attached
- EC2 metadata accessible
- Launch Template updated
- Auto Scaling replacement successful

Yet no Log Group appeared.

---

## Root Cause

The CloudWatch wizard configured:

```
/var/log/messages
```

Amazon Linux 2023 primarily uses:

```
systemd-journald
```

Therefore the configured log source did not exist, preventing CloudWatch from creating the Log Group.

The CloudWatch Agent itself was functioning correctly.

---

# 9. Lessons Learned

- Infrastructure debugging is iterative.
- Always verify operating-system defaults.
- Never assume AWS wizard defaults are correct.
- Launch Template updates require new instances.
- IAM Roles require Instance Profiles.
- Validate before troubleshooting permissions.

---

# 10. Future Improvements

- Configure CloudWatch Agent to read from journald.
- Build CloudWatch Dashboard.
- Configure CloudWatch Alarms.
- Monitor Apache access logs.
- Add custom application metrics.

---
