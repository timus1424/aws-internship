#Why Amazon Linux 2023
Amazon Linux 2023 is AWS’s own Linux distribution. It is optimized for AWS infrastructure, receives long-term security updates, integrates well with AWS services, and is lightweight compared to desktop operating systems. Since it is maintained by AWS, it is the recommended choice for learning and deploying applications on EC2.

---
# What do nano, micro, small,..., mean
This is AWS describing how powerful the virtual computer is.
imagine you are renting computers.
Size	CPU		RAM		Typical Use
nano:	Tiny		Very little	Simple experiments

micro:	Small		~1 GB		Learning, websites

small:	More		More		Small applications

medium:	Better		Better		Production workloads

large:	Powerful 	More RAM	Busy servers

xlarge:	Even bigger 	More CPUs 	Databases, analytics

The larger the instance, the more computing resources AWS gives you—and the more it generally costs.
---
# What do the subscripts mean?
The letter tells you the instance of the famil.
Family		Purpose
T	-	General purpose, burstable
C	-	Compute Optimized
R	-	Memory Optimized
M	-	Balanced
P	-	GPU
G	-	Graphics/AI

---
# .pem private keys
.pem stands for Privacy-Enhanced Mail, an old format name that stuck around.

A .pem file is your private SSH key.
It contains a cryptographic private key used to authenticate you securely to the EC2 instance.

---
#Why chmod 400

What happens with chmod 777?

The correct answer is B. SSH refuses to use the key.

SSH is intentionally strict. If your private key is readable by everyone, SSH assumes it isn’t secure and refuses to authenticate with it.

That’s why AWS recommends 400—only the file owner can read it.

---
ssh -i "timus-ec2-key.pem" ec2-user@ec2-13-127-161-38.ap-south-1.compute.amazonaws.com

-i -> use this identity/private key

ec2-user -> default Linux username for Amazon Linux
//Ubuntu - ubuntu; Debian - admin or debian; CentOS - centos

@ -> means log in as this user on that machine

ec2-13-127-161-38.ap-south-1.compute.amazonaws.com -> public name of our EC2 instance

---
#Why var and not home/ec2-user
We use /var/www/html because Apache serves files from that directory by default. The /home/ec2-user directory is the personal home folder for the ec2-user; files stored there are not automatically available on the web. By placing index.html in /var/www/html, Apache can serve it when someone visits the instance’s public IP.

---