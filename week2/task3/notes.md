---

# notes.md

```markdown
# Notes

## Apache

Install

sudo dnf install httpd -y

Start

sudo systemctl start httpd

Enable on Boot

sudo systemctl enable httpd

Status

sudo systemctl status httpd

---

## Deploy Website

Copy website

sudo cp ~/index.html /var/www/html/index.html

Verify

curl http://localhost

---

## Public Access

The website becomes publicly accessible through the EC2 Public IPv4 Address provided that:

- HTTP (Port 80) is allowed in the Security Group.
- The EC2 instance is in a public subnet.
- The Route Table has a route to the Internet Gateway.

---
