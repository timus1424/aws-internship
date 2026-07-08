#Week 2 - Task 2 Notes

## 1. TCP vs UDP
Two protocols for sending data over a network. The difference is reliability vs speed.

**TCP (Transmission Control Protocol)**
- Establishes a connection before sending data (a "handshake")
- Guarantees delivery — if a packet is lost, it resends it
- Ordered — data arrives in the correct sequence
- Slower because of these checks
- Use case: web browsing, emails, file transfers — anything where accuracy matters

**UDP (User Datagram Protocol)**
- No connection established, just fires data and hopes it arrives
- No guarantee of delivery, no reordering
- Much faster because there are no checks
- Use case: video calls, live streaming, gaming — anything where speed matters more than perfect accuracy

> **Simple rule:** TCP = reliable but slower. UDP = fast but unreliable.

---
## 2. Port Numbers
A port is a number that tells your computer *which application* a incoming packet belongs to, since multiple applications share the same network connection.

Think of it like an apartment building: the IP address is the building address, the port number is the apartment number.

**Common ports to know:**
_________________________________________
| Port 	| Protocol 			|
|------	|-------------------------------|
| 22 	| SSH (remote server access) 	|
| 80 	| HTTP (web traffic)		|
| 443 	| HTTPS (secure web traffic) 	|
| 3306 	| MySQL 			|
| 5432 	| PostgreSQL 			|
-----------------------------------------
> **Simple rule:** IP address gets you to the right machine, port number gets you to the right application on that machine.

---
## 3. Security Groups
A Security Group is AWS's **instance-level firewall** — it controls what traffic is allowed in and out of your EC2 instances or RDS databases.

- Attached directly to a resource (e.g., an EC2 instance)
- You define **inbound** rules (what traffic can come in) and **outbound** rules (what can go out)
- **Deny by default** — if a rule doesn't explicitly allow traffic, it's blocked
- Example rule: "Allow inbound TCP on port 443 from anywhere" = allow HTTPS traffic from the internet

> **Simple rule:** Security Groups are the bouncer at the door of your individual resource.

---
## 4. Network ACLs (Access Control Lists)
A Network ACL is AWS's **subnet-level firewall** — it controls traffic entering and leaving an entire subnet inside your VPC, not just one resource.

- Applied at the VPC subnet level, not individual resources
- Rules are numbered and evaluated in order — first match wins
- Unlike Security Groups, ACLs support explicit **DENY** rules
- Controls both inbound and outbound traffic independently

> **Simple rule:** ACL is the security checkpoint at the neighborhood entrance. Security Group is the lock on your individual front door.

---
## 5. Stateful vs Stateless
This explains the core difference between Security Groups and Network ACLs.

**Stateful (Security Groups)**
- Remembers the connection
- If you allow inbound traffic, the return outbound traffic is **automatically allowed** — no extra rule needed
- Example: You allow inbound HTTP on port 80. The response traffic going back to the user is automatically permitted.

**Stateless (Network ACLs)**
- Does not remember the connection
- You must explicitly create rules for **both directions** — inbound AND outbound separately
- Example: You must create one rule to allow inbound HTTP and a separate rule to allow the outbound response

> **Simple rule:** Stateful = remembers context, handles return traffic automatically. Stateless = no memory, you manually define every direction.

---
## How These All Connect

Tie-back to VPC (Stage previous): your VPC contains subnets. Network ACLs guard those subnets. Security Groups guard the individual resources inside them. TCP/UDP and ports define *what kind* of traffic those firewalls are actually filtering.

---
## 6. SSH v/s HTTP

- SSH is restricted to my public IP because it provides administrative access to the EC2 instance. Limiting access to trusted IP addresses reduces the attack surface and helps prevent unauthorized login attempts.

- HTTP is open to the internet because the web server is intended to serve content to any user. Restricting HTTP to a single IP would prevent the public from accessing the website.

---
## Security Groups

A Security Group acts as a virtual firewall for an EC2 instance. It controls which traffic is allowed to reach the instance (inbound) and which traffic is allowed to leave the instance (outbound).

Unlike Network ACLs, Security Groups are **stateful**. If an inbound request is allowed, the return traffic is automatically allowed.
### Configured Inbound Rules
_________________________________________________________________________________________________________________
| Protocol | Port | Source 		| Reason 								|
|----------|------|---------------------|-----------------------------------------------------------------------|
| SSH 	   | 22   | My Public IP (/32) 	| Allows only the administrator to securely access the EC2 instance. 	|
| HTTP 	   | 80   | 0.0.0.0/0 		| Allows anyone on the internet to access the hosted website. 		|
| HTTPS    | 443  | 0.0.0.0/0 		| Allows secure encrypted web traffic from anywhere. 			|
-----------------------------------------------------------------------------------------------------------------

---
## Why SSH is restricted to My IP

SSH provides administrative access to the EC2 instance. Allowing SSH from anywhere (0.0.0.0/0) would expose the server to automated attacks and unauthorized login attempts.

Instead, AWS stores my current public IP address (for example, `223.xxx.xxx.xxx/32`) when I select **My IP**. Only that exact IP address can establish an SSH connection.

---
## Why the SSH Rule Sometimes Stops Working
My ISP assigns a dynamic public IP address. Whenever my internet reconnects or the router restarts, my public IP may change.

Example:

Old IP:
223.xxx.xxx.xxx

New IP:
49.xxx.xxx.xxx

The Security Group still contains the old IP, so SSH connections from the new IP are denied.

To regain access, I simply edit the Security Group and replace the old IP with my current public IP.

---
## Why HTTP and HTTPS are Open to Everyone
A web server is designed to serve users across the internet.
Therefore:

- HTTP (Port 80) is open to everyone.
- HTTPS (Port 443) is open to everyone for secure encrypted communication.

This allows any user with the server's public IP or domain name to access the hosted website.

---
## Real-World Practices
Companies usually avoid changing Security Groups every time an employee's IP changes by using one of the following approaches:

- Purchasing a Static Public IP from the ISP.
- Connecting through a Corporate VPN with a fixed public IP.
- Using AWS Systems Manager (SSM), which allows secure administration without opening SSH (Port 22) to the internet.

---
## Security Group vs Network ACL

Security Group
- Applied to EC2 instances.
- Stateful.
- Primarily controls instance-level access.

Network ACL
- Applied to subnets.
- Stateless.
- Controls traffic entering and leaving an entire subnet.
- Acts as an additional layer of network security.
