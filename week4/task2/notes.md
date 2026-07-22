## CloudWatch

Monitors AWS resources.

Stores metrics.

Can trigger alarms.

Works with SNS for notifications.

---

## Dashboard

Visual representation of metrics.

No alerting.

Only visualization.

---

## Alarm

Evaluates a metric against a threshold.

Example:

CPU > 70%.

---

## SNS

Notification service.

CloudWatch publishes to SNS.

SNS sends emails.

---

## Flow

EC2
↓
CloudWatch Metric
↓
Alarm
↓
SNS
↓
Email

---

### Observation

SNS email confirmations were not received on my Gmail accounts during testing, even after requesting confirmation multiple times.
Using my institutional (SMIT) email worked immediately.

When troubleshooting SNS subscriptions:
- Verify the inbox and spam folder.
- Re-request the confirmation email if necessary.
- If confirmation is still not received, test with an alternate email provider.

Only confirmed subscriptions can receive CloudWatch notifications.

---

## Q&A:

1. Why doesn’t CloudWatch send emails directly?
-> Because CloudWatch’s responsibility is monitoring, not notification delivery. By publishing to SNS instead, the same alarm can notify multiple destinations without CloudWatch needing to know anything about them.

2. Can one SNS Topic notify Email, SMS, Lambda, SQS, etc. simultaneously?
-> Yes. That’s one of SNS’s biggest strengths. A single message published to a topic can fan out to multiple subscribers using different protocols.

---
