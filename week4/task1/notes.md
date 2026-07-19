# Week 4 - Task 1 Notes

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

5. What does Internt-facing mean?
-> An Internet-facing Load Balancer accepts requests from users on the Internet. An Internal Load Balancer only accepts traffic from resources inside the VPC and is used for internal applications.
Internt-facing ALB: Internet -> Load Balancer -> EC2
(Anyone on the internet can send requests. Perfect for websites.)
Internal ALB: EC2 -> Internal Load Balancer -> Database Server
(Nobody on the internt can access it. Only resources inside your VPC can. Used for Microservices, Internal APIs, Backend services)

6. Suppose we had /api and /images on different EC2 instances. Which Load Balancer can route based on URLs?
-> This is the word Application becomes maningful. If we visit: website.com/login, the ALB understands the request is for /login and sends it to Login Server; if another user visits website.com/images the ALB sends it to Image Server. 
A Network Load Balancer can't do that, it only knows 'someone connected', it doesn't understand URLs.
Hence we will use Application Load Balancer. 

