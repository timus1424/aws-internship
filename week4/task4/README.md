## Challenges Encountered

While attaching the IAM role, SSH connectivity to the standalone EC2 instance failed despite:

- Correct Security Group rules
- Public subnet with Internet Gateway
- Public IPv4 assigned
- Network ACL allowing all traffic
- Route table verified
- IAM role successfully attached

Troubleshooting performed:

- Verified current public IP using `curl ifconfig.me`
- Tested SSH with verbose logging (`ssh -vvv`)
- Tested TCP connectivity using `nc`
- Verified route tables, subnet configuration and NACL
- Verified Security Group inbound and outbound rules
- Verified instance networking configuration

The instance was recreated to ensure a clean deployment.
