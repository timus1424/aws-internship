## Debugging Notes

### SSH Timeout

Issue:

- Initial EC2 instance consistently timed out during SSH.

Troubleshooting:

- Verified Security Group

- Verified Route Table

- Verified Network ACL

- Verified Public IP

- Verified key pair

- Tested with ssh -vvv

- Tested connectivity using nc

Resolution:

- Recreated the standalone EC2 instance.

- New instance connected successfully using the same key pair and IAM role.

---

## Lessons Learned

- IAM Roles are more secure than storing access keys on EC2 instances.
- Customer-managed policies provide fine-grained control over AWS permissions.
- The Principle of Least Privilege minimizes security risks.
- AWS STS automatically provides temporary credentials to EC2 instances through IAM Roles.
- Systematic troubleshooting is essential when debugging cloud networking and SSH connectivity issues.

---
