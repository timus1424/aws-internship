# Week 4 - Task 1 Notes

---

Launch Template
        │
        ▼
Auto Scaling Group
        │
        ▼
Creates EC2 instances
        │
        ▼
Registers them automatically
        │
        ▼
Target Group
        │
        ▼
Application Load Balancer
        │
        ▼
Internet Users

---
_________________________________________________________________________
|Service		  |Responsibility				|
|-------------------------|---------------------------------------------|
|Application Load Balancer|Decides where each incoming request goes.	|
|			  |						|
|Auto Scaling Group	  |Decides how many EC2 instances should exist.	|
|			  |						|
|Launch Template	  |Defines how to create a new EC2 instance. 	|
-------------------------------------------------------------------------
---
## Q&A : 

1. If our current architecture has only one EC2 instance, what happens if it crashes?
-> The website becomes unavailable because the only server hosting the application has failed. The VPC, subnet, route table, Internet Gateway, and Security Group still exist, but there is no running application for users to access.
(Infrastructure still exists -> service becomes unavailable.)

2. Suppose we launch three EC2 instances, but users still connect directly to one EC2’s public IP. What problem does that create? 
-> imagine we have: EC2-1, EC2-2, EC2-3, But everyone visits http://EC2-1-IP instead of using a Load Balancer.
EC2-2 & EC2-3 receive no traffic and EC2-1 becomes overloaded. If EC2-1 crashes, the website goes down even though two healthy servers are still running, hence we don't really benefit from having multiple servers.
That's the exact problem the Load Balancer solves, it decides where each request should go, i.e., Load Balancer --EC2-1
								 						 |-EC2-2
								 						 |-EC2-3

3. If you had to explain a Load Balancer to a non-technical friend in one sentence, how would you describe it?
-> A Load Balancer receives incoming traffic and distributes it across multiple healthy servers so that no single server becomes overloaded.

4. Why is an Application Load Balancer (ALB) the best choice for our Apache website?
-> We use an Application Load Balancer because our Apache server hosts a web application over HTTP/HTTPS. An ALB understands these protocols and can intelligently distribute incoming web traffic across multiple EC2 instances.
The Application Load Balancer reads the URL and forwards the request to the appropriate backend.

5. What does Internet-facing mean?
-> An Internet-facing Load Balancer accepts requests from users on the Internet. An Internal Load Balancer only accepts traffic from resources inside the VPC and is used for internal applications.
Internt-facing ALB: Internet -> Load Balancer -> EC2
(Anyone on the internet can send requests. Perfect for websites.)
Internal ALB: EC2 -> Internal Load Balancer -> Database Server
(Nobody on the internt can access it. Only resources inside your VPC can. Used for Microservices, Internal APIs, Backend services)

6. Suppose we had /api and /images on different EC2 instances. Which Load Balancer can route based on URLs?
-> This is the word Application becomes meaningful. If we visit: website.com/login, the ALB understands the request is for /login and sends it to Login Server; if another user visits website.com/images the ALB sends it to Image Server. 
A Network Load Balancer can't do that, it only knows 'someone connected', it doesn't understand URLs.
Hence we will use Application Load Balancer. 

7. If we forget to select a Key Pair, will the Auto Scaling Group still be able to launch EC2 instances? Why or why not?
->  if we forget to select a Key Pair, the auto scaling group will still be able to create EC2 instances.
Reasoning: when selecting the key pair, we have an option- 'dont include in launch template', that means its not compulsory to add one.
A Key Pair is optional in a Launch Template. Without it, EC2 instances launch normally, but SSH access using a key pair is not available.

8. Why do you think AWS lets a Launch Template have multiple versions instead of allowing you to edit it directly?
-> Say we already have Launch Template v1 which is being used by an Auto Scaling Group, now say we decide to switch to t3.small for instance type. If AWS overwrites v1 and something goes wrong, we will have nothing to fall back on. This is the reason why AWS creates version 1 -> version2 -> version 3 -> and so on istead of destroying history. 
That gives us:    i. safe rollback
		 ii. a record of changes
		iii. control over which version an Auto Scaling Group uses.

9. Suppose our Launch Template does not specify a Security Group. Can the EC2 instance still launch? Or is a Security Group mandatory?
-> Every EC2 instance must have at least one Security Group. A Launch Template can omit it, but then the Security Group must be specified when the instance is launched (for example, by the Auto Scaling Group).

10. If we created the Load balancer before the Target Group, where would it send incoming traffic?
-> If we created the Load Balancer first, it wouldn’t know where to send incoming requests because no Target Group exists yet. The Target Group tells the Load Balancer which EC2 instances (or other targets) should receive traffic. Without it, the Load Balancer has nowhere to forward requests, so users would receive errors instead of reaching the application.

11. Why must an Application Load Balancer be placed in at least two public subnets in different Availability Zones?
-> Placing the ALB in two public subnets across different Availability Zones makes it highly available. If one Availability Zone fails, the Load Balancer can continue receiving and routing traffic through the other Availability Zone, keeping the application accessible.

12. Why are we selecting both public subnets instead of only one?
-> We select both public subnets because they belong to different Availability Zones. This allows the Auto Scaling Group to launch EC2 instances in either Availability Zone if one becomes unavailable, improving fault tolerance and high availability.

13. Why enable ELB Health Checks?
-> ELB Health Checks continuously monitor whether each EC2 instance is healthy. If an instance fails, the Load Balancer stops sending traffic to it, and the Auto Scaling Group can replace it automatically. This improves availability and prevents users from reaching failed servers.

14. What is VPC Lattice Integration?
-> It acts like an internal networking layer that lets services discover and communicate with each other securely, even if they live in different VPCs or AWS accounts.
Think of it as: A service-to-service networking platform for large distributed applications.

15. Why do we use a Target Tracking Scaling Policy instead of manually deciding when to launch new EC2 instances?
-> A Target Tracking Scaling Policy automatically adjusts the number of EC2 instances to keep a chosen metric (such as average CPU utilization) close to a target value. This removes the need to manually monitor servers and ensures the application scales up during high demand and scales down when traffic decreases.

16. Why use CPU instead of network traffic?
-> CPU utilization directly reflects how busy the web servers are processing requests. While network traffic measures data transfer, CPU is a better indicator of server workload for dynamically scaling Apache web servers.

17. Why don’t we enable Scale-in Protection for our Auto Scaling Group?
-> Scale-in Protection prevents Auto Scaling from terminating an EC2 instance during a scale-in event. Since our Apache web servers are stateless and identical, any instance can be safely replaced. Enabling Scale-in Protection would reduce Auto Scaling’s ability to remove unnecessary instances and potentially increase infrastructure costs.

18. Why do we place the Launch Template below the Auto Scaling Group in the architecture?
-> The Launch Template is not an active AWS service that launches instances on its own. Instead, it acts as a blueprint containing the EC2 configuration. Whenever the Auto Scaling Group decides that a new instance is needed, it refers to the Launch Template to create that EC2 instance.

---
