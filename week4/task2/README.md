# Week 4 - Task 2

# Amazon CloudWatch Alarm with Amazon SNS Notification

Monitor EC2 CPU utilization using Amazon CloudWatch and receive email notifications through Amazon SNS when CPU usage exceeds a configured threshold.

---

## Objective

Create a CloudWatch alarm that:

- monitors EC2 CPU utilization
- triggers when CPU usage exceeds 70%
- publishes a notification to Amazon SNS
- delivers an email notification to the subscriber

---

## Architecture

See:

```
diagrams/cloudwatch-monitoring-workflow.png
```

---

## Technologies

- Amazon EC2
- Amazon CloudWatch
- Amazon SNS
- Amazon Linux 2023

---

## Workflow

```text
EC2 Instance
      │
      ▼
CloudWatch Metrics
      │
      ▼
CloudWatch Alarm
      │
      ▼
Amazon SNS Topic
      │
      ▼
Email Notification
```

---

## Progress

- [x] Created SNS Topic
- [x] Confirmed email subscription
- [x] Created CloudWatch Alarm
- [x] Generated CPU load
- [x] Alarm entered ALARM state
- [x] Received SNS email notification
- [x] Stopped CPU load
- [x] Alarm returned to OK state

---

## Screenshots

| Step | Description |
|------|-------------|
|01|CloudWatch Overview|
|02|SNS Topic Created|
|03|Email Subscription Confirmed|
|04|CloudWatch Alarm Created|
|05|Artificial CPU Load Generated|
|06|Alarm Triggered|
|07|SNS Email Notification|
|08|CPU Load Stopped|
|09|Alarm Returned to OK|

---

## Outcome

Successfully configured an end-to-end monitoring pipeline where CloudWatch continuously monitored EC2 CPU utilization and automatically notified the subscriber through Amazon SNS whenever the configured threshold was exceeded.

---

## Observations

### Auto Scaling

The CloudWatch alarm was attached to a specific EC2 Instance ID.

If Auto Scaling replaces that instance, the alarm continues monitoring the original Instance ID instead of automatically switching to the new instance.

Production environments generally monitor Auto Scaling Groups, Load Balancers, or application-level metrics rather than individual EC2 instances.

### SNS Subscription

During testing, Gmail accounts did not receive SNS confirmation emails despite multiple confirmation requests.

Using the institutional (SMIT) email account worked immediately.

Only confirmed SNS subscriptions receive CloudWatch notifications.

---

## Repository Contents

```
README.md
notes.md
diagrams/
screenshots/
```

---
