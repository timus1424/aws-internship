# CloudFormation

AWS CloudFormation is an Infrastructure as Code (IaC) service provided 
by Amazon Web Services that allows you to model, provision, and manage AWS 
and third-party resources safely and predictably. Instead of manually 
configuring components in the AWS Management Console, you write a text 
blueprint that automates the deployment of your infrastructure.

## Core Concepts

- **Template:** A JSON or YAML formatted text file serving as the blueprint for 
your infrastructure. YAML is highly preferred for readability.

- **Stack:** A single unit of management representing a collection of AWS resources 
deployed from a template. Deleting a stack deletes all resources within 
it.

- **Change Sets:** A summary preview allowing you to review how a proposed 
template update will impact running resources before execution.

- **StackSets:** An extension enabling you to replicate stack deployments across multiple 
AWS accounts and regions simultaneously.

---

## Structure of a Template
A basic template contains several components, 
though only the Resources block is mandatory:

- AWSTemplateFormatVersion: Identifies the capabilities of the template. 
	'2010-09-09'

- Description: A text string explaining what the template provisions. 
	Description: > 
		write description of the template

- Parameters: Custom inputs provided at deployment to make templates 
reusable.

- Mappings: Static lookups (e.g., matching a Region to a specific AMI 
ID). 

- Conditions: Logical rules dictating whether specific resources are 
created. 

- Resources: The actual AWS components to build (e.g., S3 buckets, EC2 
instances). 
	everything we build goes under Resources.

- Outputs: Values returned after creation (e.g., a public IP 
address or web URL).

---
## Basic Template Example (YAML)

This simple template provisions a secure Amazon S3 bucket:

```yaml 
AWSTemplateFormatVersion: '2010-09-09' 
Description: 'A simple template to provision an Amazon S3 Bucket' 
Parameters:
  BucketNameParam:
    Type: String
    Description: 'Enter a unique name for your S3 bucket'
Resources:
  MyS3Bucket:
    Type: 'AWS::S3::Bucket'
    Properties:
      BucketName: !Ref BucketNameParam
      VersioningConfiguration:
        Status: Enabled
Outputs:
  BucketARN:
    Description: 'The Amazon Resource Name of the new bucket'
    Value: !GetAtt MyS3Bucket.Arn
```

Key BenefitsAutomation: Eliminates human configuration errors and dramatically 
speeds up resource setup.Consistency: Guarantees identical environment builds 
across development, testing, and production phases.Automatic Rollbacks: If a 
resource fails to provision properly during deployment, CloudFormation 
automatically rolls back changes and deletes temporary elements to maintain 
state integrity.Cost: The service itself is completely free; you only pay for 
the standard pricing rates of the AWS resources your template provisions.

---

### !Ref
Returns identifier of another resources (resource ID). 
It is used to connect AWS resources together without manually specifying IDs.
ex. Insatnce ID, VPC ID, Subnet ID

### !GetAtt
Returns an attribute of a resources 
ex. Public IP, DNS Name, ARN, Availability Zone

#### Difference between !Ref and !GetAtt
!Ref WebServerInstance returns i-0ab123456...
!GetAtt WebServerInstance.PublicIp returns 43.xxx.xxx.xxx 
!GetAtt WebServerInstance.PublicDnsName returns ec2-43-xxx-xxx.compute.amazonaws.com

Example:
```yaml
VpcId: !Ref Week3VPC
```

### Resources: 

Week3VPC:  --> it is the logical ID (not the VPC name, used by CF to reference the resource later)
  Type: AWS::EC2::VPC  -->every resource has a resource type. These are AWS defined.
  Properties:  ---> VPC configuration
    --
    --  (body)

#### MapPublicIpOnLaunch
Automatically assigns a public IPv4 address to every EC2 instance launched into the subnet.
Equivalent to enabling:
"Auto-assign Public IPv4 Address = Yes"
Without this, Internet-facing EC2 instances won't receive a public IP automatically.

#### DependsOn
CloudFormation is smart about many dependencies, but here we want to be explicit.
We are saying:
“Do not create this route until the Internet Gateway has been attached to the VPC.”
Without the attachment, the route could fail because the gateway isn’t ready yet.

### We do not hardcode the AMI
If AWS releases a new Amazon Linux image, the old AMI becomes deprecated.
If we hardcoded-- 'ImageId: ami-0123456789' our template (yes the whole thing) would become outdated.
#### 2 Solutions
- A. Mappings (classic CF)
Mappings:
  RegionMap:
    ap-south-1:
      AMI: ami-12345678
    us-east-1:
      AMI: ami-87654321

and when asked ImageId in EC2 instance configuration:
    ImageId: !FindInMap

- B. AWS Systems Manager Parameter Store (modern AWS)
    ImageId: !Sub '{{resolve:ssm:/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64}}'
AWS automatically resolves the latest Amazon Linux 2023 AMI for the current region. No updates required.

### UserData: --> Anything here should be executed the first time the instance boots.
- Fn::Base64 --> EC2’s UserData API expects the data to be Base64-encoded when it’s sent to AWS. CloudFormation handles the encoding for us.
- | --> is pure YAML. It means everything belo this is one multi-line string.
----

## Mental Model

CloudFormation Template (YAML)
        ↓
CloudFormation Service
        ↓
AWS creates resources
        ↓
      Stack

Instead of manually creating every AWS resource through the Console,
we describe the infrastructure once and CloudFormation provisions
everything automatically.

---

## CloudFormation Resource Flow

CloudFormation creates resources by resolving dependencies.

Week3VPC
      ↓
Week3InternetGateway
      ↓
AttachGateway
      ↓
PublicSubnet
      ↓
PublicRouteTable
      ↓
DefaultPublicRoute
      ↓
PublicSubnetRouteAssociation
      ↓
WebSecurityGroup
      ↓
EC2 Instance

Notice how later resources reference earlier ones using `!Ref`.

---
## Challenges:

1. Why are we using a /16 CIDR instead of /24 for the VPC?
-> we use a /16 instead of /24 because we get a much larger VPC. /24 gives us only 256 but /16 gives us almost 64k IP adresses. 
A VPC is supposed to contain multiple subnets. We usually allocate a large address space (/16) and then divide it into smaller /24 subnets
ex.   10.0.0.0/16
	│
	├── 10.0.1.0/24   Public Subnet
	├── 10.0.2.0/24   Private Subnet
	├── 10.0.3.0/24   Database Subnet
	└── ...

2. What’s the difference between Week3VPC and week3-cloudformation-vpc?
-> Week3VPC is kind of like the variable name which cloudformation will use to refernce to it later.
Week3VPC is CloudFormation's internal name. 
week3-cloudforamtion-vpc is the AWS Tag Name that you'll actually see in the AWS Console.
one exits for CF (Week3VPC)
The other exists for humans.

3. If we forgot EnableDnsHostnames, what practical issue might we notice with an EC2 instance?
-> 'ec2-43-205-253-190.ap-south-1.compute.amazonaws.com'
That hostname exists because DNS Hostnames are enabled.
If we disable them:
* EC2 can still run.
* It still has an IP.
* But it won’t automatically receive a public DNS hostname.
That means instead of connecting to 
'ec2-43-205-253-190.ap-south-1.compute.amazonaws.com' we would have '43.205.xxx.xxx'
Many AWS services expect or work more smoothly with DNS names, so enabling them is considered best practice for internet-facing instances.

4. Why do we need both Week3InternetGateway and AttachGateway?
-> AWS console automatically creates the Internet Gateway and connects it to a VPC, but in CloudFormation, you need to manually create both and then attach them.
Precisely: * AWS::EC2::InternetGateway creates the Internet Gateway resource.
* AWS::EC2::VPCGatewayAttachment attaches that Internet Gateway to a VPC.
They are two separate AWS API operations, so CloudFormation models them as two separate resources.

5. What does `!Ref Week3VPC` return?
   - A. The tag name (`week3-cloudformation-vpc`)
   - B. The logical ID (`Week3VPC`)
   - C. The actual VPC ID created by AWS
-> C

6. Where did you perform the equivalent of AttachGateway in the console?
-> VPC Console →Internet Gateways →Create Internet Gateway →  Action → Attach to VPC

7. How would AWS know which subnet should use which route table?
-> AWS does not know automatically. We explicitly associate each subnet with the Route Table it should use.

8. What would happen if we created the Route Table but forgot to create the SubnetRouteTableAssociation?
-> Lets say we currently have: •Public Subnet & •Public Route Table. They're both created but not connected.
The Subnet doesn't know that these are my 'routing rules'.
Therefore, when an EC2 instance inside the subnet tries to reach, say 8.8.8.8
AWS checks: Which Route Table belongs to this subnet? Since there is no connection, the packet then has nowhere to go.

9. Why is allowing SSH from 0.0.0.0/0 considered a bad security practice?
-> SSH from 0.0.0.0/0 is considered a bad security practice cause then we would be giving everyone on the internet the right to obtain shell access to the EC2 instance.

10. If this were a real production server, what would you change in this template?
->If this were a real production server, we would change the CidrIp from everywhere to just MyIP.

11. Why is HTTP allowed from 0.0.0.0/0 while SSH usually shouldn’t be?
-> HTTP is allowed from 0.0.0.0/0 because http is just accessing the service/site and that should be allowed to everyone on the internt. Changing the files or configuration, on the other hand is not allowed hence SSH isnt given that option.

12. Why do you think UserData only runs during the first boot instead of every reboot?
-> UserData runs only during the first boot because it is meant for one-time instance initialization. If it ran on every reboot, it could repeatedly reinstall software, recreate files, overwrite configurations, or perform the same setup multiple times unnecessarily.

13. Suppose your EC2 gets a new Public IP after stopping and starting. Will CloudFormation Outputs display the new IP or the old one?
-> CloudFormation Outputs display the current attribute of the resource. If the EC2 Public IP changes, the PublicIP output reflects the new IP because !GetAtt retrieves the current attribute from the instance.
---
