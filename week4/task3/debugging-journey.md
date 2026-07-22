# Debugging Journey

## Challenge 1

UserData executed successfully but instances remained unhealthy.

Root Cause

The public route table was associated with the wrong subnet.

Resolution

Associated both public subnets with the correct route table.

---

## Challenge 2

Launch Template changes did not affect running instances.

Root Cause

Launch Templates are versioned.

Resolution

Created Version 2 and updated the Auto Scaling Group to use the latest version.

---

## Challenge 3

CloudFormation development

Instead of writing the entire template at once, every logical section was validated using:

```bash
aws cloudformation validate-template \
    --template-body file://full-stack.yaml
```

This caught syntax errors early and simplified debugging.

---

## Biggest Takeaway

CloudFormation is not difficult because of YAML syntax.

The challenging part is understanding how AWS resources depend on one another. Building the template incrementally and validating after every major change made debugging much easier than writing the entire template at once.

---
