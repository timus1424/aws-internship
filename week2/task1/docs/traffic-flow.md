# Week 2 - Traffic Flow

1. A user enters the EC2 public IP in a browser.

2. The request reaches the Internet Gateway attached to the VPC.

3. The Public Route Table forwards the request to the Public Subnet.

4. The EC2 instance receives the request.

5. Apache serves the HTML page.

6. The response is returned to the client through the Internet Gateway.

7. The Private Subnet has no Internet Gateway route, so it remains isolated from direct internet access.
